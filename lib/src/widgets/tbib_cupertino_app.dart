import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mit_x/mit_x.dart';
import 'package:mit_x/src/routes/custom_transition.dart';
import 'package:mit_x/src/routes/route_redirect.dart';
import 'package:mit_x/src/routes/transition/transitions_type.dart';

class GetCupertinoApp extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final CustomTransition? customTransition;
  final Color? color;
  final Translations? translations;
  final TextDirection? textDirection;
  final Locale? locale;
  final Locale? fallbackLocale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final Map<Type, Action<Intent>>? actions;
  final Function(Routing?)? routingCallback;
  final Transition? defaultTransition;
  final bool? opaqueRoute;
  final bool? enableLog;
  final bool? popGesture;
  final Duration? transitionDuration;
  final bool? defaultGlobalState;
  final List<MitXPage>? getPages;
  final MitXPage? unknownRoute;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final CupertinoThemeData? theme;
  final bool useInheritedMediaQuery;
  const GetCupertinoApp({
    Key? key,
    this.theme,
    this.navigatorKey,
    this.home,
    Map<String, Widget Function(BuildContext)> this.routes =
        const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    List<NavigatorObserver> this.navigatorObservers =
        const <NavigatorObserver>[],
    this.builder,
    this.translations,
    this.textDirection,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.customTransition,
    this.locale,
    this.fallbackLocale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.useInheritedMediaQuery = false,
    this.unknownRoute,
    this.routingCallback,
    this.defaultTransition,
    this.getPages,
    this.opaqueRoute,
    this.enableLog = kDebugMode,
    this.popGesture,
    this.transitionDuration,
    this.defaultGlobalState,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.actions,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        super(key: key);

  GetCupertinoApp.router({
    Key? key,
    this.theme,
    this.routeInformationProvider,
    RouteInformationParser<Object>? routeInformationParser,
    RouterDelegate<Object>? routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.useInheritedMediaQuery = false,
    this.color,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.customTransition,
    this.translations,
    this.textDirection,
    this.fallbackLocale,
    this.routingCallback,
    this.defaultTransition,
    this.opaqueRoute,
    this.enableLog = kDebugMode,
    this.popGesture,
    this.transitionDuration,
    this.defaultGlobalState,
    this.getPages,
    this.unknownRoute,
  })  : routerDelegate = routerDelegate ??= MitX.createDelegate(
          notFoundRoute: unknownRoute,
        ),
        routeInformationParser =
            routeInformationParser ??= MitX.createInformationParser(
          initialRoute: getPages?.first.name ?? '/',
        ),
        navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null,
        super(key: key) {
    MitX.routerDelegate = routerDelegate;
    MitX.routeInformationParser = routeInformationParser;
  }

  @override
  State<GetCupertinoApp> createState() => _GetCupertinoAppState();
}

class _GetCupertinoAppState extends State<GetCupertinoApp> {
  @override
  void initState() {
    StaticData.navigateKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();
    if (widget.locale != null) MitX.locale = widget.locale;

    if (widget.fallbackLocale != null) {
      MitX.fallbackLocale = widget.fallbackLocale;
    }

    if (widget.translations != null) {
      MitX.addTranslations(widget.translations!.keys);
    }

    MitX.customTransition = widget.customTransition;

    if (widget.getPages != null) {
      MitX.addPages(widget.getPages!);
    }

    MitX.config(
      enableLog: widget.enableLog,
      defaultTransition: widget.defaultTransition ?? MitX.defaultTransition,
      defaultOpaqueRoute: widget.opaqueRoute ?? MitX.isOpaqueRouteDefault,
      defaultPopGesture: widget.popGesture ?? MitX.isPopGestureEnable,
      defaultDurationTransition:
          widget.transitionDuration ?? MitX.defaultTransitionDuration,
    );
    super.initState();
  }

  Widget build(BuildContext context) => widget.routerDelegate != null
      ? CupertinoApp.router(
          routerDelegate: widget.routerDelegate!,
          routeInformationParser: widget.routeInformationParser!,
          backButtonDispatcher: widget.backButtonDispatcher,
          routeInformationProvider: widget.routeInformationProvider,
          key: MitX.key,
          theme: widget.theme,
          builder: defaultBuilder,
          title: widget.title,
          onGenerateTitle: widget.onGenerateTitle,
          color: widget.color,
          locale: MitX.locale ?? widget.locale,
          localizationsDelegates: widget.localizationsDelegates,
          localeListResolutionCallback: widget.localeListResolutionCallback,
          localeResolutionCallback: widget.localeResolutionCallback,
          supportedLocales: widget.supportedLocales,
          showPerformanceOverlay: widget.showPerformanceOverlay,
          checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
          showSemanticsDebugger: widget.showSemanticsDebugger,
          debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
          shortcuts: widget.shortcuts,
          useInheritedMediaQuery: widget.useInheritedMediaQuery,
        )
      : CupertinoApp(
          theme: widget.theme,
          navigatorKey: (MitX.key),

          home: widget.home,
          routes: widget.routes ?? const <String, WidgetBuilder>{},
          initialRoute: widget.initialRoute,
          onGenerateRoute:
              (widget.getPages != null ? generator : widget.onGenerateRoute),
          onGenerateInitialRoutes:
              (widget.getPages == null || widget.home != null)
                  ? widget.onGenerateInitialRoutes
                  : initialRoutesGenerate,
          onUnknownRoute: widget.onUnknownRoute,
          navigatorObservers: (widget.navigatorObservers == null
              ? <NavigatorObserver>[
                  GetObserver(widget.routingCallback, MitX.routing)
                ]
              : <NavigatorObserver>[
                  GetObserver(widget.routingCallback, MitX.routing)
                ]
            ..addAll(widget.navigatorObservers!)),
          builder: defaultBuilder,
          title: widget.title,
          onGenerateTitle: widget.onGenerateTitle,
          color: widget.color,
          locale: MitX.locale ?? widget.locale,
          localizationsDelegates: widget.localizationsDelegates,
          localeListResolutionCallback: widget.localeListResolutionCallback,
          localeResolutionCallback: widget.localeResolutionCallback,
          supportedLocales: widget.supportedLocales,
          showPerformanceOverlay: widget.showPerformanceOverlay,
          checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
          showSemanticsDebugger: widget.showSemanticsDebugger,
          debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
          shortcuts: widget.shortcuts,
          useInheritedMediaQuery: widget.useInheritedMediaQuery,
          //   actions: actions,
        );

  Widget defaultBuilder(BuildContext context, Widget? child) {
    return Directionality(
      textDirection: widget.textDirection ??
          (rtlLanguages.contains(MitX.locale?.languageCode)
              ? TextDirection.rtl
              : TextDirection.ltr),
      child: widget.builder == null
          ? (child ?? const Material())
          : widget.builder!(context, child ?? Material()),
    );
  }

  Route<dynamic> generator(RouteSettings settings) {
    return PageRedirect(settings: settings, unknownRoute: widget.unknownRoute)
        .page();
  }

  List<Route<dynamic>> initialRoutesGenerate(String name) {
    return [
      PageRedirect(
        settings: RouteSettings(name: name),
        unknownRoute: widget.unknownRoute,
      ).page()
    ];
  }
}
