import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:mit_x/src/interface.dart';
import 'package:mit_x/src/services/lifecycle.dart';

class RouterReportManager<T> {
  /// Holds a reference to `MitX.reference` when the Instance was
  /// created to manage the memory.
  static final Map<Route?, List<String>> _routesKey = {};

  /// Stores the onClose() references of instances created with `MitX.create()`
  /// using the `MitX.reference`.
  /// Experimental feature to keep the lifecycle and memory management with
  /// non-singleton instances.
  static final Map<Route?, HashSet<Function>> _routesByCreate = {};

  void printInstanceStack() {
    MitX.log(_routesKey.toString());
  }

  static Route? _current;

  // ignore: use_setters_to_change_properties
  static void reportCurrentRoute(Route newRoute) {
    _current = newRoute;
  }

  /// Links a Class instance [S] (or [tag]) to the current route.
  /// Requires usage of `MitXMaterialApp`.
  static void reportDependencyLinkedToRoute(String depedencyKey) {
    if (_current == null) return;
    if (_routesKey.containsKey(_current)) {
      _routesKey[_current!]!.add(depedencyKey);
    } else {
      _routesKey[_current] = <String>[depedencyKey];
    }
  }

  static void clearRouteKeys() {
    _routesKey.clear();
    _routesByCreate.clear();
  }

  static void appendRouteByCreate(MitXLifeCycleBase i) {
    _routesByCreate[_current] ??= HashSet<Function>();
    // _routesByCreate[MitX.reference]!.add(i.onDelete as Function);
    _routesByCreate[_current]!.add(i.onDelete);
  }

  static void reportRouteDispose(Route disposed) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _removeDependencyByRoute(disposed);
    });
  }

  static void reportRouteWillDispose(Route disposed) {
    final keysToRemove = <String>[];

    _routesKey[disposed]?.forEach(keysToRemove.add);

    /// Removes `MitX.create()` instances registered in `routeName`.
    if (_routesByCreate.containsKey(disposed)) {
      for (final onClose in _routesByCreate[disposed]!) {
        // assure the [DisposableInterface] instance holding a reference
        // to onClose() wasn't disposed.
        onClose();
      }
      _routesByCreate[disposed]!.clear();
      _routesByCreate.remove(disposed);
    }

    keysToRemove.clear();
  }

  /// Clears from memory registered Instances associated with [routeName] when
  /// using `MitX.smartManagement` as [SmartManagement.full] or
  /// [SmartManagement.keepFactory]
  /// Meant for internal usage of `MitXPageRoute` and `MitXDialogRoute`
  static void _removeDependencyByRoute(Route routeName) {
    final keysToRemove = <String>[];

    _routesKey[routeName]?.forEach(keysToRemove.add);

    /// Removes `MitX.create()` instances registered in `routeName`.
    if (_routesByCreate.containsKey(routeName)) {
      for (final onClose in _routesByCreate[routeName]!) {
        // assure the [DisposableInterface] instance holding a reference
        // to onClose() wasn't disposed.
        onClose();
      }
      _routesByCreate[routeName]!.clear();
      _routesByCreate.remove(routeName);
    }

    for (final element in keysToRemove) {
      _routesKey[routeName]?.remove(element);
    }

    keysToRemove.clear();
  }
}
