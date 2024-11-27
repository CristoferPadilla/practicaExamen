import 'package:flutter/material.dart';
import 'package:practice/home/widgets/listview/listview_kits.dart';

class ExamenScreen extends StatelessWidget {

  const ExamenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Taller Mécanico'),
      ),
      body: Column(
        children: [
          ListViewKits()
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
