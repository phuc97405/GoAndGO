import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:goandgo/Presentation/My_App/app_controller.dart';

void getWeatherApi(latitude, longitude) async {
  try {
    String apiKey = '7904635dae4a7c586f8c087f73646e5b';
    var dio = Dio();
    var response = await dio.get(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    print(response.data.toString());
    if (response.data != null) {
      Get.find<AppController>().temp =
          double.parse(response.data['main']['temp'].toString()) - 273.15;
      Get.find<AppController>().weatherMain =
          response.data['weather'][0]['main'].toString();
    }
  } catch (e) {
    print('Get Weather Api Error: ' + e.toString());
  }
}
