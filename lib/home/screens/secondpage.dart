import 'package:flutter/material.dart';
import 'package:practice/home/domain/entities/bloc/counter_bloc.dart';
import 'package:practice/home/domain/entities/bloc/counter_event.dart';
import 'package:practice/home/domain/entities/bloc/counter_state.dart';


class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  ContadorPageState createState() => ContadorPageState();
}

class ContadorPageState extends State<SecondPage> {
  late ContadorBloc _contadorBloc;

  @override
  void initState() {
    super.initState();
    _contadorBloc = ContadorBloc();
  }

  @override
  void dispose() {
    _contadorBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador con BLoC de bajo presupuesto'),
      ),
      body: Center(
        child: StreamBuilder<ContadorState>(
          stream: _contadorBloc.contadorState,
          builder: (context, snapshot) {

            final contadorState = snapshot.data;

            if (contadorState is ContadorCargado) {
              return Text(
                'Materias reprobadas: ${contadorState.contador}',
                style: const TextStyle(fontSize: 20),
              );
            }

            return const Text('Materias reprobadas: 0', style: TextStyle(fontSize: 20),);
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _contadorBloc.contadorEventSink.add(Decrementar());
            },
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              _contadorBloc.contadorEventSink.add(Incrementar());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
