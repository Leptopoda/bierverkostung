// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart' show FirebaseFunctions;

import 'package:bierverkostung/shared/theme.dart';
import 'package:bierverkostung/shared/error_page.dart';
import 'package:bierverkostung/shared/loading.dart';
import 'package:bierverkostung/shared/enviornment_config.dart';
import 'package:bierverkostung/services/auth.dart';
import 'package:bierverkostung/services/route_generator.dart';

import 'package:bierverkostung/screens/login_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong(
            error: snapshot.error.toString(),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          if (EnvironmentConfig.localFirebase ||
              EnvironmentConfig.localFirebaseIP != 'localhost') {
            const String _host = EnvironmentConfig.localFirebaseIP;

            if (!kIsWeb) {
              FirebaseAuth.instance.useEmulator('http://$_host:9099');
            }
            FirebaseFunctions.instance
                .useFunctionsEmulator(origin: 'http://$_host:5001');

            FirebaseFirestore.instance.settings = const Settings(
              host: '$_host:8080',
              sslEnabled: false,
              persistenceEnabled: false,
            );
          } else {
            FirebaseFirestore.instance.settings =
                const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
          }

          return MultiProvider(
            providers: <StreamProvider>[
              StreamProvider<User?>.value(
                value: AuthService().user,
                initialData: null,
              ),
            ],
            child: Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
              },
              child: MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                // themeMode: ThemeMode.system,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                onGenerateTitle: (BuildContext context) =>
                    AppLocalizations.of(context)!.appName,

                home: const LoginController(),
                //initialRoute: '/Login',
                onGenerateRoute: RouteGenerator.generateRoute,
              ),
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        // TODO: maybe handle differently
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const Loading(),
        );
      },
    );
  }
}
