import 'package:flutter/material.dart';

class Keys {
  static GlobalKey<NavigatorState>? martialAppKey;
  static Map<dynamic, GlobalKey<NavigatorState>> keys = {};
  call() {
    print(keys);
  }
}
