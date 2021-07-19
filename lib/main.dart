// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:convert' show jsonEncode;
import 'dart:developer' as developer show log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, Settings;
import 'package:cloud_functions/cloud_functions.dart' show FirebaseFunctions;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;

import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/shared/loading.dart';
import 'package:bierverkostung/services/firebase/auth.dart';
import 'package:bierverkostung/services/navigation/navigation.dart';

import 'package:bierverkostung/screens/home.dart';
import 'package:bierverkostung/screens/login/login.dart';

part 'package:bierverkostung/shared/firebase_setup.dart';
part 'package:bierverkostung/shared/theme.dart';
part 'package:bierverkostung/screens/login_controller.dart';
part 'package:bierverkostung/shared/enviornment_config.dart';

/// Runs the app.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(_MyApp());
}

/// Root widget in the Widget tree.
///
/// This Widget only contains the Loading screen,
/// firebase initialization logic and [User] stream.
class _MyApp extends StatelessWidget {
  _MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, AsyncSnapshot<FirebaseApp> snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: snapshot.error.toString(),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          _setupFirebase();

          return MultiProvider(
            providers: <StreamProvider>[
              StreamProvider<User?>.value(
                value: AuthService.user,
                initialData: null,
                catchError: (context, err) {
                  if ((_EnvironmentConfig.localFirebase ||
                          _EnvironmentConfig.localFirebaseIP != 'localhost') &&
                      err.toString().contains('[ INVALID_REFRESH_TOKEN ]')) {
                    AuthService.signOut();
                    debugPrint('User has been auto singed out because of $err');
                  }
                },
              ),
            ],
            child: Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.select):
                    const ActivateIntent(),
              },
              child: MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                // themeMode: ThemeMode.system,
                theme: _AppTheme.lightTheme,
                darkTheme: _AppTheme.darkTheme,
                onGenerateTitle: (BuildContext context) =>
                    AppLocalizations.of(context)?.beertasting ?? 'Beertasting',

                home: const _LoginController(),
                //initialRoute: '/Login',
                onGenerateRoute: RouteGenerator.generateRoute,
                navigatorKey: NavigationService.navigatorKey,
              ),
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        // TODO: maybe handle differently
        return MaterialApp(
          theme: _AppTheme.lightTheme,
          darkTheme: _AppTheme.darkTheme,
          home: const Loading(),
        );
      },
    );
  }
}
