// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bierverkostung/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/trinksprueche/trinksprueche.dart';
import 'package:bierverkostung/statistiken/statistiken.dart';
import 'package:bierverkostung/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int selectedPage = 1;
  static final _pageOptions = [
    Trinksprueche(),
    Bierverkostung(),
    Statistiken()
  ];
  static const List<String> _pageTitles = ['Trinksprüche', 'Bierverkostung', 'Statistik'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bierverksotung',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: [
        // AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('de', ''),
        // const Locale('ar', ''),
      ],
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
                icon: Icon(Icons.bar_chart), label: 'Statistik'),
          ],
        ),
      ),
    );
  }
}
