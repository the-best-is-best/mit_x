import 'package:flutter/material.dart';

MaterialPageRoute mitXMaterialPageRoute(
    {required Widget page,
    bool fullscreenDialog = false,
    bool maintainState = true,
    RouteSettings? settings}) {
  return MaterialPageRoute(
    fullscreenDialog: fullscreenDialog,
    maintainState: maintainState,
    settings: settings,
    builder: (context) => page,
  );
}
