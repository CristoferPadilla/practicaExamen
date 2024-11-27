
import 'package:flutter/material.dart';
import 'package:practice/home/infra/models/pieces_model.dart';
import 'package:practice/home/screens/kits_details.dart';

// ignore: must_be_immutable
class ListViewKits extends StatelessWidget {
  const ListViewKits({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        child: ListView.builder(
          itemCount: kitsList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(kitsList[index].name),
              subtitle: Text('Price: \$${kitsList[index].price}'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => KitsDatailsScreen(
                        kitsList: [kitsList[index]],
                      )),
                )
              },
            );
          },
        ));
  }
}


