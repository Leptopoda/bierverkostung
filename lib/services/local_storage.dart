// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// Helpers to handle local KV storage
class LocalDatabaseService {
  const LocalDatabaseService();

  /// key for the firstRun parameter
  static const String _firstRun = 'first_run';

  /// key for the drinkResponsible parameter
  static const String _drinkResponsible = 'drink_responsible';

  /// key for the drinkSafe parameter
  static const String _drinkSafe = 'drink_safe';

  /// sets the FirstLogin parameter to
  static Future<void> setFirstLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_firstRun, DateTime.now().toString());
  }

  /// gets the FirstLogin parameter
  static Future<DateTime?> getFirstLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _firstRunTime = prefs.getString(_firstRun);
    return _firstRunTime != null ? DateTime.tryParse(_firstRunTime) : null;
  }

  /// sets the DrinkResponsible parameter
  static Future<void> setDrinkResponsible() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_drinkResponsible, true);
  }

  /// gets the DrinkResponsible parameter
  static Future<bool?> getDrinkResponsible() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_drinkResponsible);
  }

  /// sets the DrinkSafe parameter
  static Future<void> setDrinkSafe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_drinkSafe, true);
  }

  /// gets the DrinkSafe parameter
  static Future<bool?> getDrinkSafe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_drinkSafe);
  }
}
