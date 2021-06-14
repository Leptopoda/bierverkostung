// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabaseService {
  const LocalDatabaseService();

  static Future<void> setFirstLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_run', true);
  }

  static Future<bool?> getFirstLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_run');
  }

  static Future<void> setDrinkResponsible() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('drink_responsible', true);
  }

  static Future<bool?> getDrinkResponsible() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('drink_responsible');
  }

  static Future<void> setDrinkSafe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('drink_safe', true);
  }

  static Future<bool?> getDrinkSafe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('drink_safe');
  }
}
