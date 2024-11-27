// contador_state.dart
abstract class ContadorState {}

class ContadorInicial extends ContadorState {
  final int contador;
  ContadorInicial({this.contador = 0});
}

class ContadorCargando extends ContadorState {}

class ContadorCargado extends ContadorState {
  final int contador;
  ContadorCargado({required this.contador});
}
