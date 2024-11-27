import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice/home/infra/models/pokemon_model.dart';

class PokemonRepository {
  Future<Pokemon> fetchPokemon(String pokemonName) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Pokemon(
        nombre: jsonData['name'],
        imagenUrl: jsonData['sprites']['front_default'] ?? '',
        stats: jsonData['stats'],
      );
    } else {
      throw Exception('Error al obtener el Pokémon');
    }
  }
}
