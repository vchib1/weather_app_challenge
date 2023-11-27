import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import '../geolocator/gelocator_service.dart';

const String apiKey = "807bf957df660eabddfe5cc570a0039d";

class API {
  static Future<List<Weather>> fetchFiveDayWeather() async {
    try {
      WeatherFactory factory = WeatherFactory(apiKey);

      Position? position = await GeolocatorService.getPosition();

      List<Weather> list = await factory.fiveDayForecastByLocation(
          position!.latitude, position.longitude);

      return list
          .where(
              (weather) => getTiming(DateTime.now().hour) == weather.date!.hour)
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Weather> fetchWeatherByCity({required String cityName}) async {
    try {
      WeatherFactory factory = WeatherFactory(apiKey);

      Weather weather = await factory.currentWeatherByCityName(cityName);

      return weather;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static int getTiming(int hour) {
    if (hour <= 11) {
      return 11;
    } else if (hour <= 14 && hour > 11) {
      return 14;
    } else if (hour <= 17 && hour > 14) {
      return 17;
    } else if (hour <= 20 && hour > 17) {
      return 20;
    } else {
      return 23;
    }
  }
}
