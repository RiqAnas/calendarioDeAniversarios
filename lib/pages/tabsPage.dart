import 'package:aniversariodois/pages/homePage.dart';
import 'package:aniversariodois/pages/mainPage.dart';
import 'package:flutter/material.dart';

class Tabspage extends StatefulWidget {
  @override
  State<Tabspage> createState() => _TabspageState();
}

class _TabspageState extends State<Tabspage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {'title': 'Notas', 'page': Mainpage()},
    {'title': 'Aniversários', 'page': Homepage()},
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Notas",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Pessoas",
          ),
        ],
      ),
      body: _pages[_selectedIndex]['page'] as Widget,
    );
  }
}
