// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:bierverkostung/screens/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/screens/trinkspiele/trinkspiele.dart';
import 'package:bierverkostung/screens/promille_rechner/promille_rechner.dart';
import 'package:bierverkostung/screens/statistiken/new_statistiken.dart';
import 'package:bierverkostung/screens/settings/settings_button.dart';
import 'package:bierverkostung/screens/statistiken/disp_statistiken.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemSelected(int index) {
    _onPageChanged(index);
    _pageController.animateToPage(
      index,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  static const List<Widget?> _pageFAB = [
    null,
    BierverkostungFab(),
    StatistikenFab(),
  ];

  static const List<String> _pageTitles = [
    "Trinkspiele",
    "Bierverkostung",
    "Statistik",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        actions: const <Widget>[
          PromilleRechnerButton(),
          SettingsButton(),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const <Widget>[
          Trinkspiele(),
          Bierverkostung(),
          Statistiken(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: (int index) => _onItemSelected(index),

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.casino_outlined),
            label: _pageTitles[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: _pageTitles[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.show_chart),
            label: _pageTitles[2],
          ),
        ],
      ),
      floatingActionButton: _pageFAB[_selectedIndex],
    );
  }
}
