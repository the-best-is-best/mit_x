import 'package:flutter/material.dart';

abstract class MitXInterface {
  RouterDelegate? routerDelegate;
  RouteInformationParser? routeInformationParser;
}

class _GetImpl extends MitXInterface {
  void log(String string) {}
}

// ignore: non_constant_identifier_names
final MitX = _GetImpl();
