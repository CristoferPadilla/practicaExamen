import 'package:flutter/material.dart';
import 'package:practice/home/domain/entities/builder/weather_services.dart';
import 'package:practice/home/infra/models/weather_model.dart';

class WeatherNotifier extends ChangeNotifier {
  final WeatherService _weatherService;
  WeatherData? _currentWeather;
  String? _currentLocation;
  bool _isLoading = false;

  WeatherNotifier(this._weatherService);

  WeatherData? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;

  bool _isAlertVisible =
      false;

  bool get isAlertVisible => _isAlertVisible;

  set isAlertVisible(bool value) {
    _isAlertVisible = value;
    notifyListeners();
  }

  Future<void> fetchWeather(BuildContext context, String location) async {
    if (_currentLocation == location && _currentWeather != null) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _currentWeather = await _weatherService.getWeather(context, location);
      _currentLocation = location;
    } catch (error) {
      _currentWeather = null;
      throw Exception('Error fetching weather: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
