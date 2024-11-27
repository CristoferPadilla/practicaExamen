import 'package:practice/home/infra/models/weather_model.dart';

class WeatherDataAdapter {
  final bool isKelvin;

  WeatherDataAdapter({this.isKelvin = false});

  WeatherData adapt(Map<String, dynamic> json) {
    double convertTemperature(double temp) =>
        isKelvin ? temp - 273.15 : temp;

    return WeatherData(
      location: json['name'],
      temperature: convertTemperature(json['main']['temp']),
      condition: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      thermalSensation: convertTemperature(json['main']['feels_like']),
    );
  }
}
