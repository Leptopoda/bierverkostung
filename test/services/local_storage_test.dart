// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:bierverkostung/services/local_storage.dart';

void main() {
  group('Local database', () {
    test('value should not be set', () async {
      expect(await LocalDatabaseService.getDrinkSafe(), null);
    });

    test('value should not be set', () async {
      expect(await LocalDatabaseService.getDrinkResponsible(), null);
    });

    test('value should not be set', () async {
      expect(await LocalDatabaseService.getFirstLogin(), null);
    });
  });
}
