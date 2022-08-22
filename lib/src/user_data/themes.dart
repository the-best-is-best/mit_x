import 'package:flutter/material.dart';

class ThemesAndroid {
  // static ThemeData? lightTheme;
  // static ThemeData? darkTheme;
  static ThemeMode _themeMode = ThemeMode.system;

  static set seThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
  }

  static ThemeMode get getThemeMode => _themeMode;
}
