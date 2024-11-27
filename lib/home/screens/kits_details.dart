import 'package:flutter/material.dart';
import 'package:practice/home/infra/models/pieces_model.dart';
import 'package:practice/home/widgets/listview/listview_pieces.dart';

// ignore: must_be_immutable
class KitsDatailsScreen extends StatelessWidget {
  KitsDatailsScreen({super.key, required this.kitsList});
  List<KitsModel> kitsList = [];

  @override
  Widget build(BuildContext context) {
    if (kitsList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No hay kits para mostrar'),
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            ListviewPieces(pieces: kitsList.first.pieces)
          ],
        ),
      );
    }
  }
}