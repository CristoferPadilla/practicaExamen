// contador_bloc.dart
import 'dart:async';

import 'package:practice/home/domain/entities/bloc/counter_event.dart';
import 'package:practice/home/domain/entities/bloc/counter_state.dart';


class ContadorBloc {
  int _contador = 0;

  final _contadorStateController = StreamController<ContadorState>();

  final _contadorEventController = StreamController<ContadorEvent>();

  ContadorBloc() {
    // Escuchar los eventos y procesarlos
    _contadorEventController.stream.listen(_mapEventToState);
  }

  Stream<ContadorState> get contadorState => _contadorStateController.stream;

  Sink<ContadorEvent> get contadorEventSink => _contadorEventController.sink;

  void _mapEventToState(ContadorEvent event) {
    if (event is Incrementar) {
      _contador++;
    } else if (event is Decrementar) {
      _contador--;
    }

    _contadorStateController.add(ContadorCargado(contador: _contador));
  }

  void dispose() {
    _contadorStateController.close();
    _contadorEventController.close();
  }
}
