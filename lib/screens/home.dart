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
  int _selectedPage = 1;

  // TODO: use enum
  static final _pageOptions = [
    const Trinkspiele(),
    const Bierverkostung(),
    const Statistiken(),
  ];
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
          title: Text(_pageTitles[_selectedPage]),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Log Out',
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => const LogOutAlert(),
              ),
            ),
            /* IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ), */
          ],
        ),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          // selectedItemColor: Colors.amber[800],
          onTap: (int index) => setState(() => _selectedPage = index),

          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.casino),
              label: _pageTitles[0],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: _pageTitles[1],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: _pageTitles[2],
            ),
          ],
        ),
        floatingActionButton: _pageFAB[_selectedPage],
      );
    } else {
      return const Login();
    }
  }
}
