import 'package:flutter/material.dart';
import 'package:practice/home/domain/entities/builder/weather_builder.dart';
import 'package:practice/home/domain/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherNotifier = Provider.of<WeatherNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Clima de bajo presupuesto',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(context),
            Expanded(
              child: Center(
                child: weatherNotifier.isLoading
                    ? const CircularProgressIndicator()
                    : weatherNotifier.currentWeather == null
                        ? _buildNoData()
                        : _buildWeatherInfo(context, weatherNotifier),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final TextEditingController controller = TextEditingController();


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Ingresa una ubicación',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              final location = controller.text.trim();
              if (location.isNotEmpty) {
                await Provider.of<WeatherNotifier>(context, listen: false)
                    .fetchWeather(context, location);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('Buscar'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoData() {
    return const Text(
      'No hay datos disponibles. Busca un clima.',
      style: TextStyle(fontSize: 16, color: Colors.grey),
    );
  }

  Widget _buildWeatherInfo(BuildContext context, WeatherNotifier weatherNotifier) {
    final weather = weatherNotifier.currentWeather!;

    final weatherCard = WeatherCardBuilder()
        .setLocation(weather.location)
        .setTemperature(weather.temperature)
        .setCondition(weather.condition)
        .setHumidity(weather.humidity)
        .setThermalSensation(weather.thermalSensation)
        .build();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: weatherCard,
    );
  }
}
