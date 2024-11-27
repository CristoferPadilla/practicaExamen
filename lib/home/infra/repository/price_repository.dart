import 'dart:math';

class PriceRepository {
  final Map<String, double> prices = {
    'Aceite': 0,
    'Tapa': 0,
    'Filtro de aceite': 0,
    'Tapón': 0,
  };

double getPrice(String name) {
  if (prices[name] == 0) {
    prices[name] = _generateRandomPrice();
  }
  return prices[name]!.roundToDouble();
}

  double _generateRandomPrice() {
    final random = Random();
    return random.nextDouble() * 50 + 1;
  }
}