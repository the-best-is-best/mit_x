import 'package:flutter/material.dart';
import 'package:mit_x/mit_x.dart';
import 'package:mit_x/src/platform/platform.dart';
import 'package:mit_x/src/routes/custom_transition.dart';
import 'package:mit_x/src/routes/transition/transitions_type.dart';

class StaticData {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static ThemeData? theme;
  static ThemeData? darkTheme;
  static ThemeMode? themeMode;

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static bool defaultPopGesture = MitXPlatform.isAndroid;
  static bool defaultOpaqueRoute = true;

  static Transition? defaultTransition;
  static Duration defaultTransitionDuration = const Duration(milliseconds: 300);
  static Curve defaultTransitionCurve = Curves.easeOutQuad;

  static Curve defaultDialogTransitionCurve = Curves.easeOutQuad;

  static Duration defaultDialogTransitionDuration =
      const Duration(milliseconds: 300);

  static final routing = Routing();

  static Map<String, String?> parameters = {};

  static CustomTransition? customTransition;

  static var navigateKey =
      GlobalKey<NavigatorState>(debugLabel: 'Key Created by default');

  static Map<dynamic, GlobalKey<NavigatorState>> keys = {};

  static GlobalKey<NavigatorState>? addKey(GlobalKey<NavigatorState> newKey) {
    navigateKey = newKey;
    return navigateKey;
  }

  static void setTheme(ThemeData value) {
    if (darkTheme == null) {
      theme = value;
    } else {
      if (value.brightness == Brightness.light) {
        theme = value;
      } else {
        darkTheme = value;
      }
    }
  }

  static void setThemeMode(ThemeMode value) {
    themeMode = value;
  }
}
