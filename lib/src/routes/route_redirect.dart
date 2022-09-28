import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mit_x/src/extensions/tbib_extensions.dart';
import 'package:mit_x/src/interface.dart';
import 'package:mit_x/src/routes/config/get_nav_config.dart';
import 'package:mit_x/src/routes/default_route.dart';
import 'package:mit_x/src/routes/mit_route.dart';
import 'package:mit_x/src/routes/transition/transitions_type.dart';

abstract class _RouteMiddleware {
  /// The Order of the Middlewares to run.
  ///
  /// {@tool snippet}
  /// This Middewares will be called in this order.
  /// ```dart
  /// final middlewares = [
  ///   GetMiddleware(priority: 2),
  ///   GetMiddleware(priority: 5),
  ///   GetMiddleware(priority: 4),
  ///   GetMiddleware(priority: -8),
  /// ];
  /// ```
  ///  -8 => 2 => 4 => 5
  /// {@end-tool}
  int? priority;

  /// This function will be called when the page of
  /// the called route is being searched for.
  /// It take RouteSettings as a result an redirect to the new settings or
  /// give it null and there will be no redirecting.
  /// {@tool snippet}
  /// ```dart
  /// GetPage redirect(String route) {
  ///   final authService = Get.find<AuthService>();
  ///   return authService.authed.value ? null : RouteSettings(name: '/login');
  /// }
  /// ```
  /// {@end-tool}
  RouteSettings? redirect(String route);

  /// Similar to [redirect],
  /// This function will be called when the router delegate changes the
  /// current route.
  ///
  /// The default implmentation is to navigate to
  /// the input route, with no redirection.
  ///
  /// if this returns null, the navigation is stopped,
  /// and no new routes are pushed.
  /// {@tool snippet}
  /// ```dart
  /// GetNavConfig? redirect(GetNavConfig route) {
  ///   final authService = Get.find<AuthService>();
  ///   return authService.authed.value ? null : RouteSettings(name: '/login');
  /// }
  /// ```
  /// {@end-tool}
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route);

  /// This function will be called when this Page is called
  /// you can use it to change something about the page or give it new page
  /// {@tool snippet}
  /// ```dart
  /// GetPage onPageCalled(GetPage page) {
  ///   final authService = Get.find<AuthService>();
  ///   return page.copyWith(title: 'Welcome ${authService.UserName}');
  /// }
  /// ```
  /// {@end-tool}
  MitXPage? onPageCalled(MitXPage page);
  MitXPageBuilder? onPageBuildStart(MitXPageBuilder page);

  /// This function will be called right after the
  /// GetPage.page function is called and will give you the result
  /// of the function. and take the widget that will be showed.
  Widget onPageBuilt(Widget page);

  void onPageDispose();
}

/// The Page Middlewares.
/// The Functions will be called in this order
/// (( [redirect] -> [onPageCalled] -> [onBindingsStart] ->
/// [onPageBuildStart] -> [onPageBuilt] -> [onPageDispose] ))
class MitXMiddleware implements _RouteMiddleware {
  @override
  int? priority = 0;

  MitXMiddleware({this.priority});

  @override
  RouteSettings? redirect(String? route) => null;

  @override
  MitXPage? onPageCalled(MitXPage? page) => page;

  @override
  MitXPageBuilder? onPageBuildStart(MitXPageBuilder? page) => page;

  @override
  Widget onPageBuilt(Widget page) => page;

  @override
  void onPageDispose() {}

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) =>
      SynchronousFuture(route);
}

class MiddlewareRunner {
  MiddlewareRunner(this._middlewares);

  final List<MitXMiddleware>? _middlewares;

  List<MitXMiddleware> _getMiddlewares() {
    final _m = _middlewares ?? <MitXMiddleware>[];
    return _m
      ..sort(
        (a, b) => (a.priority ?? 0).compareTo(b.priority ?? 0),
      );
  }

  MitXPage? runOnPageCalled(MitXPage? page) {
    _getMiddlewares().forEach((element) {
      page = element.onPageCalled(page);
    });
    return page;
  }

  RouteSettings? runRedirect(String? route) {
    RouteSettings? to;
    for (final element in _getMiddlewares()) {
      to = element.redirect(route);
      if (to != null) {
        break;
      }
    }
    MitX.log('Redirect to $to');
    return to;
  }

  MitXPageBuilder? runOnPageBuildStart(MitXPageBuilder? page) {
    _getMiddlewares().forEach((element) {
      page = element.onPageBuildStart(page);
    });
    return page;
  }

  Widget runOnPageBuilt(Widget page) {
    _getMiddlewares().forEach((element) {
      page = element.onPageBuilt(page);
    });
    return page;
  }

  void runOnPageDispose() =>
      _getMiddlewares().forEach((element) => element.onPageDispose());
}

class PageRedirect {
  MitXPage? route;
  MitXPage? unknownRoute;
  RouteSettings? settings;
  bool isUnknown;

  PageRedirect({
    this.route,
    this.unknownRoute,
    this.isUnknown = false,
    this.settings,
  });

  // redirect all pages that needes redirecting
  GetPageRoute<T> page<T>() {
    while (needRecheck()) {}
    final _r = (isUnknown ? unknownRoute : route)!;
    return GetPageRoute<T>(
      page: _r.page,
      parameter: _r.parameters,
      settings: isUnknown
          ? RouteSettings(
              name: _r.name,
              arguments: settings!.arguments,
            )
          : settings,
      curve: _r.curve,
      opaque: _r.opaque,
      showCupertinoParallax: _r.showCupertinoParallax,
      gestureWidth: _r.gestureWidth,
      customTransition: _r.customTransition,
      transitionDuration:
          _r.transitionDuration ?? MitX.defaultTransitionDuration,
      transition: _r.transition,
      popGesture: _r.popGesture,
      fullscreenDialog: _r.fullscreenDialog,
    );
  }

  // redirect all pages that needes redirecting
  GetPageRoute<T> getPageToRoute<T>(MitXPage rou, MitXPage? unk) {
    while (needRecheck()) {}
    final _r = (isUnknown ? unk : rou)!;

    return GetPageRoute<T>(
      page: _r.page,
      parameter: _r.parameters,
      alignment: _r.alignment,
      title: _r.title,
      maintainState: _r.maintainState,
      routeName: _r.name,
      settings: _r,
      curve: _r.curve,
      showCupertinoParallax: _r.showCupertinoParallax,
      gestureWidth: _r.gestureWidth,
      opaque: _r.opaque,
      customTransition: _r.customTransition,
      transitionDuration:
          _r.transitionDuration ?? MitX.defaultTransitionDuration,
      transition: _r.transition,
      popGesture: _r.popGesture,
      fullscreenDialog: _r.fullscreenDialog,
    );
  }

  /// check if redirect is needed
  bool needRecheck() {
    if (settings == null && route != null) {
      settings = route;
    }
    final match = MitX.routeTree.matchRoute(settings!.name!);
    MitX.parameters = match.parameters;

    // No Match found
    if (match.route == null) {
      isUnknown = true;
      return false;
    }

    final runner = MiddlewareRunner(match.route!.middlewares);
    route = runner.runOnPageCalled(match.route);
    addPageParameter(route!);

    // No middlewares found return match.
    if (match.route!.middlewares == null || match.route!.middlewares!.isEmpty) {
      return false;
    }
    final newSettings = runner.runRedirect(settings!.name);
    if (newSettings == null) {
      return false;
    }
    settings = newSettings;
    return true;
  }

  void addPageParameter(MitXPage route) {
    if (route.parameters == null) return;

    final parameters = MitX.parameters;
    parameters.addEntries(route.parameters!.entries);
    MitX.parameters = parameters;
  }
}
