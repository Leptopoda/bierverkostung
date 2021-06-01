// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:bierverkostung/services/local_storage.dart';

void main() {
  group('Local database', () {
    test('value should not be set', () async {
      expect(await LocalDatabaseService().getDrinkSafe(), null);
    });

    test('value should not be set', () async {
      expect(await LocalDatabaseService().getDrinkResponsible(), null);
    });

    test('value should not be set', () async {
      expect(await LocalDatabaseService().getFirstLogin(), null);
    });
  });
}
