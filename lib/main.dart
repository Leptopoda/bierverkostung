// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/trinksprueche/trinksprueche.dart';
import 'package:bierverkostung/statistiken/statistiken.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int selectedPage = 1;
  final _pageOptions = [Trinksprueche(), Bierverkostung(), Statistiken()];
  final _pageTitles = ['Trinksprüche', 'Bierverkostung', 'Statistik'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bierverksotung',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primarySwatch: Colors.yellow,
          accentColor: Colors.amber[800],

          // Define the default font family.
          // fontFamily: 'Georgia',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          /* textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ), */
        ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_pageTitles[selectedPage]),
        ),
        body: _pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          // selectedItemColor: Colors.amber[800],
          onTap: (int index) {
            setState(() {
              selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Trinksprüche'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Bierverkostung'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: 'Statistik')
          ],
        ),
      ),
    );
  }
}
