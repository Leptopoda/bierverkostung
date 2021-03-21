import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const _primarySwatch = Colors.yellow;
  static const _accentColor = Colors.amber[800];

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: _primarySwatch,
    accentColor: _accentColor,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: _primarySwatch,
    accentColor: _accentColor,
  );
}
