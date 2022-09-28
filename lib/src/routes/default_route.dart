import 'package:flutter/material.dart';
import 'package:mit_x/src/routes/mixin/get_transition_mixin.dart';
import 'package:mit_x/src/routes/custom_transition.dart';
import 'package:mit_x/src/routes/route_redirect.dart';
import 'package:mit_x/src/routes/routes_report.dart';
import 'package:mit_x/src/routes/transition/transitions_type.dart';

mixin PageRouteReportMixin<T> on Route<T> {
  @override
  void install() {
    super.install();
    RouterReportManager.reportCurrentRoute(this);
  }

  @override
  void dispose() {
    super.dispose();
    RouterReportManager.reportRouteDispose(this);
  }
}

class GetPageRoute<T> extends PageRoute<T>
    with GetPageRouteTransitionMixin<T>, PageRouteReportMixin {
  /// Creates a page route for use in an iOS designed app.
  ///
  /// The [builder], [maintainState], and [fullscreenDialog] arguments must not
  /// be null.
  GetPageRoute({
    RouteSettings? settings,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.parameter,
    this.gestureWidth,
    this.curve,
    this.alignment,
    this.transition,
    this.popGesture,
    this.customTransition,
    this.barrierDismissible = false,
    this.barrierColor,
    this.routeName,
    this.page,
    this.title,
    this.showCupertinoParallax = true,
    this.barrierLabel,
    this.maintainState = true,
    bool fullscreenDialog = false,
    this.middlewares,
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  final Duration transitionDuration;
  final MitXPageBuilder? page;
  final String? routeName;
  //final String reference;
  final CustomTransition? customTransition;
  final Map<String, String>? parameter;

  @override
  final bool showCupertinoParallax;

  @override
  final bool opaque;
  final bool? popGesture;

  @override
  final bool barrierDismissible;
  final Transition? transition;
  final Curve? curve;
  final Alignment? alignment;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  final List<MitXMiddleware>? middlewares;

  Widget? _child;

  Widget _getChild() {
    if (_child != null) return _child!;
    final middlewareRunner = MiddlewareRunner(middlewares);

    final pageToBuild = middlewareRunner.runOnPageBuildStart(page)!;
    _child = middlewareRunner.runOnPageBuilt(pageToBuild());
    return _child!;
  }

  @override
  Widget buildContent(BuildContext context) {
    return _getChild();
  }

  @override
  final String? title;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  final double Function(BuildContext context)? gestureWidth;
}
