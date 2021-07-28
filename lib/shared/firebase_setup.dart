// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/main.dart';

/// Sets up firebase components.
/// When compiled for local testing it will set up for emulator usage.
Future<void> _setupFirebase() async {
  try {
    if (_EnvironmentConfig.isLocal) {
      const String _host = _EnvironmentConfig.localFirebaseIP;

      if (!kIsWeb) {
        await FirebaseAuth.instance.useAuthEmulator(_host, 9099);
      }
      FirebaseFunctions.instance.useFunctionsEmulator(_host, 5001);

      FirebaseFirestore.instance.settings = const Settings(
        host: '$_host:8080',
        sslEnabled: false,
        persistenceEnabled: false,
      );

      await FirebaseStorage.instance.useStorageEmulator(_host, 9199);
    } else {
      FirebaseFirestore.instance.settings =
          const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    }
  } catch (error) {
    developer.log(
      'Firebase init error',
      name: 'leptopoda.bierverkostung.initFirebas',
      error: jsonEncode(error.toString()),
    );
  }
}
