import 'package:flutter/material.dart';

class WeatherCardBuilder {
  //Incializar las variables
  String? _location;
  double? _temperature;
  String? _condition;
  int? _humidity;
  double? _thermalSensation;
  

  WeatherCardBuilder setLocation(String location) {
    _location = location;
    return this;
  }

  WeatherCardBuilder setTemperature(double temperature) {
    _temperature = temperature;
    return this;
  }

  WeatherCardBuilder setCondition(String condition) {
    _condition = condition;
    return this;
  }

  WeatherCardBuilder setHumidity(int humidity) {
    _humidity = humidity;
    return this;
  }

  WeatherCardBuilder setThermalSensation(double thermalSensation) {
    _thermalSensation = thermalSensation;
    return this;
  }

Map<String, dynamic> _getWeatherIconAndColor() {
  if (_condition == null) {
    return {
      'icon': Icons.help_outline,
      'color': Colors.grey, 
    };
  }

  final condition = _condition!.toLowerCase();

  if (condition.contains('lluvia') || condition.contains('rain')) {
    return {
      'icon': Icons.umbrella,
      'color': Colors.blue,
    };
  } else if (condition.contains('tormenta') || condition.contains('storm')) {
    return {
      'icon': Icons.flash_on,
      'color': Colors.yellow,
    };
  } else if (condition.contains('nieve') || condition.contains('snow')) {
    return {
      'icon': Icons.ac_unit,
      'color': Colors.lightBlueAccent,
    };
  } else if (condition.contains('nublado') || condition.contains('cloud') ||  condition.contains('nuboso')) {
    return {
      'icon': Icons.cloud,
      'color': Colors.grey,
    };
  } else {
    return {
      'icon': Icons.wb_sunny,
      'color': Colors.orange,
    };
  }
}


//TODO DISEÑO DE LA TARJETA
  Widget build() {
    return Column(
      children: [
        // Información de la ubicación y el icono del clima
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                     _getWeatherIconAndColor()['icon'],
                      size: 28,
                      color: _getWeatherIconAndColor()['color'],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _location ?? 'Ubicación no definida',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Icon(
                 _getWeatherIconAndColor()['icon'],
                  size: 80,
                  color: _getWeatherIconAndColor()['color'],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Temperatura y descripción del clima
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      '${_temperature?.toStringAsFixed(1)}°C',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const Text(
                      'Temperatura',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.cloud_queue,
                      size: 40,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _condition ?? 'Condición no definida',
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Humedad y otra información adicional
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.opacity,
                      size: 40,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_humidity?.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Humedad'),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.thermostat,
                      size: 40,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_thermalSensation?.toStringAsFixed(1)}°C',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Sensación Térmica'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
