import 'package:dio/dio.dart';

Future getWeatherApi(String latitude, String longitude) async {
  try {
    Response response;
    String apiKey = '7904635dae4a7c586f8c087f73646e5b';
    var dio = Dio();
    response = await dio.get(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    String temp =
        ((double.parse(response.data['main']['temp'].toString()) - 273.15)
                .round())
            .toString();
    print('devvv' + temp);
    return temp;
  } catch (e) {
    print('Get Weather Api Error: ' + e.toString());
  }
}
