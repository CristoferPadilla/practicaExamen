import 'package:flutter/material.dart';
import 'package:practice/home/infra/models/pieces_model.dart';

class ListviewPieces extends StatelessWidget {
  final List<PiecesModel> pieces;

  const ListviewPieces({super.key, required this.pieces});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: pieces.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(pieces[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: \$${pieces[index].price}'),
                Text(
                    'Mano de obra: ${pieces[index].labour.inMinutes} minutos'),
              ],
            ),
          );
        },
      ),
    );
  }
}
