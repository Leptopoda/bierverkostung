// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

class EnvironmentConfig {
  static const localFirebase = bool.fromEnvironment(
    'local_firebase',
    // defaultValue: false
  );

  static const localFirebaseIP = String.fromEnvironment(
    'local_firebase_ip',
    defaultValue: 'localhost'
  );
}
