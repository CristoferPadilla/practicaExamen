import 'package:flutter/material.dart';
import 'package:practice/home/presenter/controllers/pokemon_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<PokemonController>(context);


    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dataProvider =
          Provider.of<PokemonController>(context, listen: false);
      if (dataProvider.foundPokemon != null && !dataProvider.hasShownSnackBar) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              dataProvider.foundPokemon!,
              style: const TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        dataProvider.markSnackBarAsShown();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex de bajo presupuesto')),
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 42, 215, 212),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 14, 14),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 1),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 247, 12),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 1),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 251, 229, 30),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            height: 320,
            width: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              border: Border.all(color: Colors.grey, width: 18),
            ),
            child: dataProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const SizedBox(height: 10),
                      // Nombre del Pokémon
                      Text(
                        dataProvider.pokemon?.nombre ?? 'Pokémon no encontrado',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Imagen del Pokémon
                          dataProvider.pokemon?.imagenUrl.isNotEmpty == true
                              ? Image.network(
                                  dataProvider.pokemon!.imagenUrl,
                                  height: 150,
                                )
                              : const Text('No image available'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              ...?dataProvider.pokemon?.stats.map((stat) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    '${stat['stat']['name']}: ${stat['base_stat']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
          ),
          Row(
            children: [
              Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                    height: 25,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 247, 12),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 25,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 251, 229, 30),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 251, 229, 30),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Busca tu Pokémon',
                    border: InputBorder.none,
                  ),
                  controller: _controller,
                ),
              ),
              GestureDetector(
                //Entrada de nombre del pokemon
                onTap: () {
                  if (_controller.text.isNotEmpty &&
                      double.tryParse(_controller.text) == null) {
                    dataProvider.fetchPokemon(_controller.text.toLowerCase());
                    _controller.clear();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Text(
                              'Por favor, ingresa el nombre de un Pokémon'),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 117, 9, 2),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
