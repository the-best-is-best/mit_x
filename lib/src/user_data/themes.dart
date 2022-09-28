import 'package:flutter/material.dart';

class ThemesAndroid {
  static ThemeMode _themeMode = ThemeMode.system;

  static set seThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
  }

  static ThemeMode get getThemeMode => _themeMode;
}
