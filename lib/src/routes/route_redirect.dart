import 'package:flutter/material.dart';
import 'package:mit_x/src/extensions/tbib_extensions.dart';
import 'package:mit_x/src/interface.dart';
import 'package:mit_x/src/routes/default_route.dart';
import 'package:mit_x/src/routes/mit_route.dart';
import 'package:mit_x/src/routes/transition/transitions_type.dart';

class RunnerGetRoutePage {
  MitXPage? runOnPageCalled(MitXPage? page) {
    return page;
  }

  RouteSettings? runRedirect(String? route) {
    RouteSettings? to;

    MitX.log('Redirect to $to');
    return to;
  }

  MitXPageBuilder? runOnPageBuildStart(MitXPageBuilder? page) {
    return page;
  }

  Widget runOnPageBuilt(Widget page) {
    return page;
  }
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

    final runner = RunnerGetRoutePage();
    route = runner.runOnPageCalled(match.route);
    addPageParameter(route!);
    return false;
  }

  void addPageParameter(MitXPage route) {
    if (route.parameters == null) return;

    final parameters = MitX.parameters;
    parameters.addEntries(route.parameters!.entries);
    MitX.parameters = parameters;
  }
}
