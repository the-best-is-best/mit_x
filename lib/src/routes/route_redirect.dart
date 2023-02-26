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
    final r = (isUnknown ? unknownRoute : route)!;
    return GetPageRoute<T>(
      page: r.page,
      parameter: r.parameters,
      settings: isUnknown
          ? RouteSettings(
              name: r.name,
              arguments: settings!.arguments,
            )
          : settings,
      curve: r.curve,
      opaque: r.opaque,
      showCupertinoParallax: r.showCupertinoParallax,
      gestureWidth: r.gestureWidth,
      customTransition: r.customTransition,
      transitionDuration:
          r.transitionDuration ?? MitX.defaultTransitionDuration,
      transition: r.transition,
      popGesture: r.popGesture,
      fullscreenDialog: r.fullscreenDialog,
    );
  }

  // redirect all pages that needes redirecting
  GetPageRoute<T> getPageToRoute<T>(MitXPage rou, MitXPage? unk) {
    while (needRecheck()) {}
    final r = (isUnknown ? unk : rou)!;

    return GetPageRoute<T>(
      page: r.page,
      parameter: r.parameters,
      alignment: r.alignment,
      title: r.title,
      maintainState: r.maintainState,
      routeName: r.name,
      settings: r,
      curve: r.curve,
      showCupertinoParallax: r.showCupertinoParallax,
      gestureWidth: r.gestureWidth,
      opaque: r.opaque,
      customTransition: r.customTransition,
      transitionDuration:
          r.transitionDuration ?? MitX.defaultTransitionDuration,
      transition: r.transition,
      popGesture: r.popGesture,
      fullscreenDialog: r.fullscreenDialog,
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
