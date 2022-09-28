import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mit_x/mit_x.dart';
import 'package:mit_x/src/routes/custom_transition.dart';
import 'package:mit_x/src/routes/route_redirect.dart';
import 'package:mit_x/src/routes/transition/transitions_type.dart';

class MitXPage<T> extends Page<T> {
  final MitXPageBuilder page;
  final bool? popGesture;
  final Map<String, String>? parameters;
  final String? title;
  final Transition? transition;
  final Curve curve;
  final bool? participatesInRootNavigator;
  final Alignment? alignment;
  final bool maintainState;
  final bool opaque;
  final double Function(BuildContext context)? gestureWidth;
  final CustomTransition? customTransition;
  final Duration? transitionDuration;
  final bool fullscreenDialog;
  final bool preventDuplicates;
  final List<MitXMiddleware>? middlewares;

  // @override
  // final LocalKey? key;

  // @override
  // RouteSettings get settings => this;

  @override
  final Object? arguments;

  @override
  final String name;

  final List<MitXPage> children;
  final PathDecoded path;
  final MitXPage? unknownRoute;
  final bool showCupertinoParallax;

  MitXPage({
    required this.name,
    required this.page,
    this.title,
    this.participatesInRootNavigator,
    this.gestureWidth,
    // RouteSettings settings,
    this.maintainState = true,
    this.curve = Curves.linear,
    this.alignment,
    this.parameters,
    this.opaque = true,
    this.transitionDuration,
    this.popGesture,
    this.transition,
    this.customTransition,
    this.fullscreenDialog = false,
    this.children = const <MitXPage>[],
    this.unknownRoute,
    this.arguments,
    this.showCupertinoParallax = true,
    this.middlewares,
    this.preventDuplicates = true,
  })  : path = _nameToRegex(name),
        assert(name.startsWith('/'),
            'It is necessary to start route name [$name] with a slash: /$name'),
        super(
          key: ValueKey(name),
          name: name,
          arguments: MitX.arguments,
        );
  // settings = RouteSettings(name: name, arguments: Get.arguments);

  MitXPage<T> copy({
    String? name,
    MitXPageBuilder? page,
    bool? popGesture,
    Map<String, String>? parameters,
    String? title,
    Transition? transition,
    Curve? curve,
    Alignment? alignment,
    bool? maintainState,
    bool? opaque,
    CustomTransition? customTransition,
    Duration? transitionDuration,
    bool? fullscreenDialog,
    RouteSettings? settings,
    List<MitXPage>? children,
    MitXPage? unknownRoute,
    bool? preventDuplicates,
    final double Function(BuildContext context)? gestureWidth,
    bool? participatesInRootNavigator,
    Object? arguments,
    bool? showCupertinoParallax,
    List<MitXMiddleware>? middlewares,
  }) {
    return MitXPage(
      participatesInRootNavigator:
          participatesInRootNavigator ?? this.participatesInRootNavigator,
      preventDuplicates: preventDuplicates ?? this.preventDuplicates,
      name: name ?? this.name,
      page: page ?? this.page,
      popGesture: popGesture ?? this.popGesture,
      parameters: parameters ?? this.parameters,
      title: title ?? this.title,
      transition: transition ?? this.transition,
      curve: curve ?? this.curve,
      alignment: alignment ?? this.alignment,
      maintainState: maintainState ?? this.maintainState,
      opaque: opaque ?? this.opaque,
      customTransition: customTransition ?? this.customTransition,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      middlewares: middlewares,
      children: children ?? this.children,
      unknownRoute: unknownRoute ?? this.unknownRoute,
      gestureWidth: gestureWidth ?? this.gestureWidth,
      arguments: arguments ?? this.arguments,
      showCupertinoParallax:
          showCupertinoParallax ?? this.showCupertinoParallax,
    );
  }

  @override
  Route<T> createRoute(BuildContext context) {
    // return GetPageRoute<T>(settings: this, page: page);
    final _page = PageRedirect(
      route: this,
      settings: this,
      unknownRoute: unknownRoute,
    ).getPageToRoute<T>(this, unknownRoute);

    return _page;
  }

  static PathDecoded _nameToRegex(String path) {
    var StaticData = <String?>[];

    String _replace(Match pattern) {
      var buffer = StringBuffer('(?:');

      if (pattern[1] != null) buffer.write('\.');
      buffer.write('([\\w%+-._~!\$&\'()*,;=:@]+))');
      if (pattern[3] != null) buffer.write('?');

      StaticData.add(pattern[2]);
      return "$buffer";
    }

    var stringPath = '$path/?'
        .replaceAllMapped(RegExp(r'(\.)?:(\w+)(\?)?'), _replace)
        .replaceAll('//', '/');

    return PathDecoded(RegExp('^$stringPath\$'), StaticData);
  }
}

@immutable
class PathDecoded {
  final RegExp regex;
  final List<String?> keys;
  const PathDecoded(this.regex, this.keys);

  @override
  int get hashCode => regex.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PathDecoded &&
        other.regex == regex; // && listEquals(other.StaticData, StaticData);
  }
}
