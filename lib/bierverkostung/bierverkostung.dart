import 'package:flutter/material.dart';

class Bierverkostung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bierverkostung"),
        // backgroundColor: Colors.green,
      ),
      body: NavBar(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class NavBar extends StatefulWidget {

  @override
  _NavBarState createState() => _NavBarState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavBarState extends State<NavBar> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch(_selectedIndex) {
      case 0: {
        Navigator.pushNamed(context,  '/trinksprueche');
      }
      break;

      case 2: {
        Navigator.pushNamed(context,  '/statistiken');
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bierverkostung',
          style: optionStyle,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Trinksprüche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Bierverkostung',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}