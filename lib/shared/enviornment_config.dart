// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/main.dart';

/// Enviornment configutation
///
/// Enables devs to start the app with compile time options
class _EnvironmentConfig {
  /// defines the usage of the firebase emulator on [localhost]
  static const localFirebase = bool.fromEnvironment(
    'local_firebase',
    // defaultValue: false
  );

  /// defines the usage of the firebase emulator on the specified local ip adress
  /// defaults to [localFirebase] when not specivfied
  static const localFirebaseIP = String.fromEnvironment(
    'local_firebase_ip',
    defaultValue: 'localhost',
  );
}
