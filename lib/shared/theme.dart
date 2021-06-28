// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/main.dart';

/// Theme Data
///
/// Contains all the data used to theme the application
@immutable
class _AppTheme {
  const _AppTheme._();
  static const _primarySwatch = Colors.yellow;
  static const _accentColor = Color(0xFFFF8F00); //Colors.orange[800]

  /// returns the light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: _primarySwatch,
    accentColor: _accentColor,
    toggleableActiveColor: _primarySwatch,
  );

  /// returns the dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: _primarySwatch,
    accentColor: _accentColor,
    toggleableActiveColor: _primarySwatch,
  );
}
