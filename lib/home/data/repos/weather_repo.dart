import 'dart:convert';

import 'package:f_bloc/home/data/datasources/weather_data_provider.dart';
import 'package:f_bloc/home/data/models/weather_model.dart';

class WeatherRepo {
  final WeatherDataProvider _weatherDataProvider;
  WeatherRepo(this._weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'Tashkent';

      final weatherData = await _weatherDataProvider.getCurrentWeather(
        cityName,
      );

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw Exception('Failed to load weather data');
      }

      return WeatherModel.fromJson(weatherData); //fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
