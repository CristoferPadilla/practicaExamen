import 'package:flutter/material.dart';
import 'package:practice/home/infra/models/pokemon_model.dart';
import 'package:practice/home/infra/repository/pokemon_repository.dart';

class PokemonController with ChangeNotifier {
  final PokemonRepository _repository;

  Pokemon? _pokemon;
  bool _isLoading = false;
  String _error = '';
  String? _foundPokemon;
  bool _hasShownSnackBar = false; 

  PokemonController(this._repository);

  bool get isLoading => _isLoading;
  String get error => _error;
  Pokemon? get pokemon => _pokemon;
  String? get foundPokemon => _foundPokemon;
  bool get hasShownSnackBar => _hasShownSnackBar;

  Future<void> fetchPokemon(String pokemonName) async {
    _isLoading = true;
    _error = '';
    _foundPokemon = null;
    _hasShownSnackBar = false; 
    notifyListeners();

    try {
      _pokemon = await _repository.fetchPokemon(pokemonName);
      _foundPokemon = "¡Pokémon encontrado: ${_pokemon!.nombre}!";
    } catch (error) {
      _error = 'Error: $error';
    }

    _isLoading = false;
    notifyListeners();
  }

  void markSnackBarAsShown() {
    _hasShownSnackBar = true;
    notifyListeners();
  }
}
