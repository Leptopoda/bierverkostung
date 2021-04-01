// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:bierverkostung/screens/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/screens/trinkspiele/trinkspiele.dart';
import 'package:bierverkostung/screens/statistiken/statistiken.dart';
import 'package:bierverkostung/screens/settings.dart';
import 'package:bierverkostung/screens/login.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  late int _selectedIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 1;
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

  static final _pageFAB = [
    null,
    const BierverkostungFab(),
    const StatistikenFab(),
  ];
  //TODO: rework stats to incorperate alcometer
  static const List<String> _pageTitles = [
    "Trinkspiele",
    "Bierverkostung",
    "Statistik",
  ];

  @override
  Widget build(BuildContext context) {
    final User? _user = Provider.of<User?>(context);
    final bool _loggedIn = _user != null;

    if (_loggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_pageTitles[_selectedIndex]),
          actions: const <Widget>[
            GroupManagement(),
            LogOutAlert(),
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

          items: [
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
    } else {
      return const Login();
    }
  }
}
