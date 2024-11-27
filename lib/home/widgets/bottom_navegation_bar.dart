import 'package:flutter/material.dart';
import 'package:practice/home/screens/examn.dart';
import 'package:practice/home/screens/homepage.dart';
import 'package:practice/home/screens/secondpage.dart';
import 'package:practice/home/screens/wheate_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int indexScreen = 0;

  final List<Widget> _tap = [ const HomePage(),  const SecondPage(),  const WeatherScreen(),   const ExamenScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _tap[indexScreen],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor:Colors.black,
          currentIndex: indexScreen,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            setState(() {
              indexScreen = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_outlined,
                color: Colors.white,
              ),
              label: 'Pokedex',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.padding, color: Colors.white),
              label: 'Otro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud, color: Colors.white),
              label: 'Clima',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list, color: Colors.white),
              label: 'Examen',
            ),
          ],
          unselectedLabelStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
