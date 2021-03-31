// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by a APACHE-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const _primarySwatch = Colors.yellow;
  static final _accentColor = Colors.amber[800];

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: _primarySwatch,
    accentColor: _accentColor,
    toggleableActiveColor: _primarySwatch,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: _primarySwatch,
    accentColor: _accentColor,
    toggleableActiveColor: _primarySwatch,
  );
}
