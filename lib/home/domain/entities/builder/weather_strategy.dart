
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/home/infra/models/weather_adapter.dart';
import 'package:practice/home/infra/models/weather_model.dart';
import 'package:practice/home/infra/repository/weather_repository.dart';


class RainAlertStrategy implements WeatherAlertStrategy {
  @override
  Future<void> notify(BuildContext context, String location, double temperature, String condition) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('⚠️ Alerta de Lluvia'),
          content: Text('Se pronostican lluvias en $location. Temperatura: $temperature°C.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}


class HeatAlertStrategy implements WeatherAlertStrategy {
  @override
  Future<void> notify(BuildContext context, String location, double temperature, String condition) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('⚠️ Alerta de Calor'),
          content: Text('Hace mucho calor en $location: $temperature°C. ¡Mantente hidratado!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}
class ColdAlertStrategy implements WeatherAlertStrategy {
  @override
  Future<void> notify(BuildContext context, String location, double temperature, String condition) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🧊 Clima frío'),
          content: Text('El clima en $location es bastante frío: $condition, $temperature°C.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}

class NoAlertStrategy implements WeatherAlertStrategy {
  @override
  Future<void> notify(BuildContext context, String location, double temperature, String condition) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🌞 Clima Agradable'),
          content: Text('El clima en $location es agradable: $condition, $temperature°C.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}

//Api de OpenWeatherMap

class OpenWeatherMapStrategy implements WeatherApiStrategy {
  final String _apiKey = 'ddbc51ed4030a30bef4bf33c8a5beab6';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  @override
  Future<WeatherData> fetchWeather(String location) async {
    if (location.isEmpty) {
      throw Exception('El nombre de la ciudad no puede estar vacío.');
    }

    final response = await http.get(
        Uri.parse('$_baseUrl?q=$location&appid=$_apiKey&units=metric&lang=es'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      
      final adapter = WeatherDataAdapter(isKelvin: false);
      return adapter.adapt(json);
    } else {
      throw Exception(_handleHttpError(response.statusCode));
    }
  }

  String _handleHttpError(int statusCode) {
    switch (statusCode) {
      case 404:
        return 'Ciudad no encontrada. Verifica el nombre e intenta de nuevo.';
      case 429:
        return 'Demasiadas peticiones. Intenta nuevamente más tarde.';
      case 500:
        return 'Error del servidor. Intenta de nuevo más tarde.';
      default:
        return 'Error inesperado: Código $statusCode.';
    }
  }
}
