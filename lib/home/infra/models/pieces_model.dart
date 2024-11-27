import 'package:practice/home/infra/repository/price_repository.dart';

class PiecesModel {
  final double id;
  final String name;
  final double price;
  final Duration labour; 

  PiecesModel({
    required this.id,
    required this.name,
    required this.price,
    required this.labour,
  });
}

class KitsModel extends PiecesModel {
  final List<PiecesModel> pieces;

  KitsModel({
    required super.id,
    required super.name,
    this.pieces = const [],
  }) : super(
          price: _calculateKitPrice(pieces),
          labour: _calculateLabour(pieces),
        );

  static double _calculateKitPrice(List<PiecesModel> pieces) {
    double totalPrice = 0;
    for (var piece in pieces) {
      totalPrice += piece.price;
    }
    return (totalPrice * 0.9).roundToDouble(); // 10% de descuento en kits
  }

  static Duration _calculateLabour(List<PiecesModel> pieces) {
    Duration totalLabour = Duration.zero;
    for (var piece in pieces) {
      totalLabour += piece.labour;
    }
    return totalLabour;
  }
}

PriceRepository priceRepository = PriceRepository();

List<KitsModel> kitsList = [
  KitsModel(
    id: 1,
    name: 'Kit 1',
    pieces: [
      PiecesModel(
        id: 1,
        name: 'Aceite',
        price: priceRepository.getPrice('Aceite'),
        labour: Duration(minutes: 30), // Media hora de trabajo
      ),
      PiecesModel(
        id: 2,
        name: 'Tapa',
        price: priceRepository.getPrice('Tapa'),
        labour: Duration(minutes: 15),
      ),
      PiecesModel(
        id: 3,
        name: 'Filtro de aceite',
        price: priceRepository.getPrice('Filtro de aceite'),
        labour: Duration(minutes: 20),
      ),
    ],
  ),
  KitsModel(
    id: 2,
    name: 'Kit 2',
    pieces: [
      PiecesModel(
        id: 4,
        name: 'Tapa',
        price: priceRepository.getPrice('Tapa'),
        labour: Duration(minutes: 15),
      ),
      PiecesModel(
        id: 5,
        name: 'Aceite',
        price: priceRepository.getPrice('Aceite'),
        labour: Duration(minutes: 30),
      ),
    ],
  ),
  KitsModel(
    id: 3,
    name: 'Kit 3',
    pieces: [
      PiecesModel(
        id: 6,
        name: 'Tapón',
        price: priceRepository.getPrice('Tapón'),
        labour: Duration(minutes: 10),
      ),
      PiecesModel(
        id: 7,
        name: 'Filtro de aceite',
        price: priceRepository.getPrice('Filtro de aceite'),
        labour: Duration(minutes: 20),
      ),
    ],
  ),
];
