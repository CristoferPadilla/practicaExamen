
import 'package:flutter/material.dart';
import 'package:practice/home/infra/models/weather_model.dart';

abstract class WeatherApiStrategy {
  Future<WeatherData> fetchWeather(String location);
}
abstract class WeatherAlertStrategy {
  void notify(BuildContext context, String location, double temperature, String condition);
}
