// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:bierverkostung/bierverkostung/bierverkostung.dart';
import 'package:bierverkostung/trinksprueche/trinksprueche.dart';
import 'package:bierverkostung/statistiken/statistiken.dart';


void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bierverkostung Rimikis',
      initialRoute: '/',
      routes: {
        '/': (context) => Bierverkostung(),
        '/statistiken': (context) => Statistiken(),
        '/trinksprueche': (context) => Trinksprueche(),
      },
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
    );
  }
// #enddocregion build
}
// #enddocregion MyApp


