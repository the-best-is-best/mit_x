import 'package:flutter/material.dart';

class Keys {
  static GlobalKey<NavigatorState>? martialAppKey;
  static Map<dynamic, GlobalKey<NavigatorState>> keys = {};
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}
