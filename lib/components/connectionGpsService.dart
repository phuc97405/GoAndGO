import 'dart:async';

import 'package:get/state_manager.dart';
import 'package:goandgo/Api/get_weather_api.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart' as geo;

class ConnectionGpsService extends GetxService {
  final controllerApp = Get.find<AppController>();
  Timer? getWeatherTime;
  StreamSubscription<geo.Position>? _positionStreamSubscription;
  StreamSubscription<geo.ServiceStatus>? _locationServiceStatusSubscription;
  @override
  void onInit() async {
    super.onInit();
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
    ].request();
    _positionStreamSubscription = geo.Geolocator.getPositionStream().listen(
      (geo.Position position) {
        controllerApp.lat!.value = position.latitude.toString();
        controllerApp.long!.value = position.longitude.toString();
        print(controllerApp.lat.toString() +
            '   ' +
            controllerApp.long.toString());
      },
      onError: (error) => {
        controllerApp.temp!.value = 0,
        controllerApp.lat!.value = '',
        controllerApp.long!.value = '',
        getWeatherTime?.cancel(),
        print('error listen possition')
      },
    );

    var result = await Permission.locationWhenInUse.serviceStatus;
    print(result);
    if (result.isEnabled) {
      await getApi();
    }

    _locationServiceStatusSubscription = geo.Geolocator.getServiceStatusStream()
        .listen((geo.ServiceStatus status) async {
      if (status == geo.ServiceStatus.enabled) {
        Get.snackbar('On Gps', '');
        await getApi();
      } else {
        controllerApp.temp!.value = 0;
        controllerApp.lat!.value = '';
        controllerApp.long!.value = '';
        getWeatherTime?.cancel();
        Get.snackbar('Off Gps', '');
      }
    });
  }

  Future getApi() async {
    await Future.delayed(Duration(seconds: 5));
    if (controllerApp.lat!.value != '' && controllerApp.long!.value != '') {
      await getWeatherApi(controllerApp.lat!.value, controllerApp.long!.value)
          .then((value) =>
              controllerApp.temp!.value = int.parse(value.toString()));
      getWeatherTime =
          Timer.periodic(Duration(seconds: 60), (Timer timer) async {
        await getWeatherApi(controllerApp.lat!.value, controllerApp.long!.value)
            .then((value) =>
                controllerApp.temp!.value = int.parse(value.toString()));
      });
    }
  }
}
