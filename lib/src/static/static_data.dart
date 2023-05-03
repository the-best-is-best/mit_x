import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/material.dart';
import 'package:mit_x/mit_x.dart';
import 'package:mit_x/src/platform/platform.dart';
import 'package:mit_x/src/routes/custom_transition.dart';

class StaticData {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static ThemeData? theme;
  static ThemeData? darkTheme;
  static ThemeMode? themeMode;
  static fluent.FluentThemeData? fluentTheme;
  static fluent.FluentThemeData? darkFluentTheme;
  static fluent.FluentThemeData? fluentThemeMode;
  static macos.MacosThemeData? macosTheme;
  static macos.MacosThemeData? darkMacosTheme;
  static macos.MacosThemeData? macosThemeMode;
  static bool macosFluent = false;
  static bool androidFluent = false;
  static bool linuxFluent = false;
  static bool windowsFluent = true;

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  static void setFluentTheme(fluent.FluentThemeData value) {
    if (darkTheme == null) {
      fluentTheme = value;
    } else {
      if (value.brightness == Brightness.light) {
        fluentTheme = value;
      } else {
        darkFluentTheme = value;
      }
    }
  }

  static void setMacosTheme(macos.MacosThemeData value) {
    if (darkTheme == null) {
      macosTheme = value;
    } else {
      if (value.brightness == Brightness.light) {
        macosTheme = value;
      } else {
        darkMacosTheme = value;
      }
    }
  }

  static void setThemeMode(ThemeMode value) {
    themeMode = value;
  }
}
