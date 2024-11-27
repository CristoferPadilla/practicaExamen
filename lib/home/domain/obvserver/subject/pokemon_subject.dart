import 'package:practice/home/domain/obvserver/pokemon_observer.dart';

class Subject {
  final List<Observer> _observers = [];

  // Método para añadir un observador
  void addObserver(Observer observer) {
    _observers.add(observer);
  }

  // Método para eliminar un observador
  void removeObserver(Observer observer) {
    _observers.remove(observer);
  }

  // Método para notificar a todos los observadores
  void notifyObservers(String message) {
    for (var observer in _observers) {
      observer.update(message);
    }
  }
}
