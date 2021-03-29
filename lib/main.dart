// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bierverkostung/shared/theme.dart';

import 'package:bierverkostung/screens/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/screens/trinkspiele/trinkspiele.dart';
import 'package:bierverkostung/screens/statistiken/statistiken.dart';
import 'package:bierverkostung/screens/settings.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
      home: SafeArea(
        child: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return SomethingWentWrong();
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return MyHome();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Loading();
          },
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SomethingWentWrong'),
      ),
      body: Center(
        child: const Text(
            'Die Einhörner versuchen dieses Problem schnellstens zu beheben',
            style: TextStyle(fontSize: 18.0)),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
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
  static final _pageFAB = [
    null,
    BierverkostungFab(),
    StatistikenFab(),
  ];
  //TODO: rework stats to incorperate alcometer
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
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
              icon: Icon(Icons.casino), label: _pageTitles[0]),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: _pageTitles[1]),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: _pageTitles[2]),
        ],
      ),
      floatingActionButton: _pageFAB[_selectedPage],
    );
  }
}
