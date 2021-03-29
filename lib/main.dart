// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bierverkostung/shared/theme.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/shared/loading.dart';

import 'package:bierverkostung/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // themeMode: ThemeMode.system,
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
              return SomethingWentWrong(error: snapshot.error.toString());
            }
            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return const MyHome();
            }
            // Otherwise, show something whilst waiting for initialization to complete
            return const Loading();
          },
        ),
      ),
    );
  }
}
