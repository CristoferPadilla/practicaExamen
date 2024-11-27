import 'package:flutter/material.dart';
import 'package:practice/home/domain/entities/builder/weather_services.dart';
import 'package:practice/home/domain/entities/builder/weather_strategy.dart';
import 'package:practice/home/domain/provider/weather_provider.dart';
import 'package:practice/home/infra/models/taskmodel_notifier.dart';
import 'package:practice/home/infra/repository/pokemon_repository.dart';
import 'package:practice/home/presenter/controllers/pokemon_controller.dart';
import 'package:practice/home/widgets/bottom_navegation_bar.dart';
import 'package:provider/provider.dart';

void main() {
  final pokemonRepository = PokemonRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonController(pokemonRepository), 
          
        ),
        ChangeNotifierProvider(
          create: (_) => TaskModel(), 
          
        ),
        ChangeNotifierProvider(create: (_) =>  WeatherNotifier(WeatherService(OpenWeatherMapStrategy())))
      
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomNavigationBar(),
      ),
    );
  }
}
