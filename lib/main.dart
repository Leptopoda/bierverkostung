// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bierverkostung/theme/theme.dart';

import 'package:bierverkostung/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/trinkspiele/trinkspiele.dart';
import 'package:bierverkostung/statistiken/statistiken.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appName,
      home: SafeArea(child: MyHome()),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  int _selectedPage = 1;

  // TODO: use enum
  static final _pageOptions = [Trinkspiele(), Bierverkostung(), Statistiken()];
  static const List<String> _pageTitles = [
    "Trinkspiele",
    "Bierverkostung",
    "Statistik",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedPage]),
      ),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        // selectedItemColor: Colors.amber[800],
        onTap: (int index) => setState(() => _selectedPage = index),

        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.casino), label: _pageTitles[0]),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: _pageTitles[1]),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: _pageTitles[2]),
        ],
      ),
      floatingActionButton: _selectedPage == 2 ? StatistikenFab() : null,
    );
  }
}
