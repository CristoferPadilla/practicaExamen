import 'package:flutter/material.dart';
import 'package:practice/home/domain/entities/builder/weather_strategy.dart';
import 'package:practice/home/infra/models/weather_model.dart';
import 'package:practice/home/infra/repository/weather_repository.dart';

class WeatherService {
  WeatherApiStrategy _strategy;
  WeatherAlertStrategy _alertStrategy = NoAlertStrategy();
  bool _isNotifying = false;

  WeatherService(this._strategy);

  set strategy(WeatherApiStrategy strategy) {
    _strategy = strategy;
  }

  Future<WeatherData> getWeather(BuildContext context, String location) async {
    final weatherData = await _strategy.fetchWeather(location);

    if (!_isNotifying) {
      _isNotifying = true;

      if (weatherData.condition.toLowerCase().contains('lluvia') ||
          weatherData.condition.toLowerCase().contains('tormenta') ||
          weatherData.condition.toLowerCase().contains('rain')) {
        _alertStrategy = RainAlertStrategy();
      } else if (weatherData.temperature > 35) {
        _alertStrategy = HeatAlertStrategy();
      } else if (weatherData.temperature < 10) {
        _alertStrategy = ColdAlertStrategy();
      } else {
        _alertStrategy = NoAlertStrategy();
      }

      _alertStrategy.notify(
        // ignore: use_build_context_synchronously
        context,
        weatherData.location,
        weatherData.temperature,
        weatherData.condition,
      );

      _isNotifying = false;
    }

    return weatherData;
  }
}
