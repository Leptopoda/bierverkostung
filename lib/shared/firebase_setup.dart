// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart' show FirebaseFunctions;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;

import 'package:bierverkostung/shared/enviornment_config.dart';

Future<void> setupFirebase() async {
  if (EnvironmentConfig.localFirebase ||
      EnvironmentConfig.localFirebaseIP != 'localhost') {
    const String _host = EnvironmentConfig.localFirebaseIP;

    if (!kIsWeb) {
      await FirebaseAuth.instance.useEmulator('http://$_host:9099');
    }
    FirebaseFunctions.instance
        .useFunctionsEmulator(origin: 'http://$_host:5001');

    FirebaseFirestore.instance.settings = const Settings(
      host: '$_host:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );

    await FirebaseStorage.instance.useEmulator(host: _host, port: 9919);
  } else {
    FirebaseFirestore.instance.settings =
        const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  }
}
