import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mit_x/mit_x.dart';
import 'package:mit_x/src/routes/custom_transition.dart';
import 'package:mit_x/src/routes/route_redirect.dart';

class MitXPlatFormApp extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
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
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final CustomTransition? customTransition;
  final Color? color;
  final Map<String, Map<String, String>>? translationsKey;
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
  final ScrollBehavior? scrollBehavior;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final Map<Type, Action<Intent>>? actions;
  final bool debugShowMaterialGrid;
  final ValueChanged<Routing?>? routingCallback;
  final Transition? defaultTransition;
  final bool? opaqueRoute;
  final bool? enableLog;
  final bool? popGesture;
  final Duration? transitionDuration;
  final bool? defaultGlobalState;
  final List<MitXPage>? mitXPages;
  final MitXPage? unknownRoute;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final CupertinoThemeData? cupertinoTheme;
  final TargetPlatform? initialPlatform;
  const MitXPlatFormApp({
    super.key,
    //   this.navigatorKey,
    this.scaffoldMessengerKey,
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
    this.textDirection,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.fallbackLocale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.scrollBehavior,
    this.customTransition,
    this.translationsKey,
    this.translations,
    this.routingCallback,
    this.defaultTransition,
    this.mitXPages,
    this.opaqueRoute,
    this.enableLog = kDebugMode,
    this.popGesture,
    this.transitionDuration,
    this.defaultGlobalState,
    this.unknownRoute,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.actions,
    this.navigatorKey,
    this.cupertinoTheme,
    this.initialPlatform,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null;

  MitXPlatFormApp.router({
    super.key,
    this.routeInformationProvider,
    this.scaffoldMessengerKey,
    RouteInformationParser<Object>? routeInformationParser,
    RouterDelegate<Object>? routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.scrollBehavior,
    this.actions,
    this.customTransition,
    this.translationsKey,
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
    this.mitXPages,
    this.navigatorObservers,
    this.unknownRoute,
    this.navigatorKey,
    this.cupertinoTheme,
    this.initialPlatform,
  })  : routerDelegate = routerDelegate ??= MitX.createDelegate(
          notFoundRoute: unknownRoute,
        ),
        routeInformationParser =
            routeInformationParser ??= MitX.createInformationParser(
          initialRoute: mitXPages?.first.name ?? '/',
        ),
        //navigatorObservers = null,
        //       navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null {
    MitX.routerDelegate = routerDelegate;
    MitX.routeInformationParser = routeInformationParser;
  }

  @override
  State<MitXPlatFormApp> createState() => _MitXPlatFormAppState();
}

class _MitXPlatFormAppState extends State<MitXPlatFormApp> {
  @override
  void initState() {
    StaticData.navigateKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();
    if (widget.mitXPages != null) {
      MitX.addPages(widget.mitXPages!);
    }

    if (widget.translations != null) {
      MitX.addTranslations(widget.translations!.keys);
    } else if (widget.translationsKey != null) {
      MitX.addTranslations(widget.translationsKey!);
    }

    if (widget.locale != null) MitX.locale = widget.locale;

    if (widget.fallbackLocale != null) {
      MitX.fallbackLocale = widget.fallbackLocale;
    }

    MitX.customTransition = widget.customTransition;

    MitX.config(
      enableLog: widget.enableLog,
      defaultTransition: widget.defaultTransition ?? MitX.defaultTransition,
      defaultOpaqueRoute: widget.opaqueRoute ?? MitX.isOpaqueRouteDefault,
      defaultPopGesture: widget.popGesture ?? MitX.isPopGestureEnable,
      defaultDurationTransition:
          widget.transitionDuration ?? MitX.defaultTransitionDuration,
    );
    MitX.locale ??= widget.supportedLocales.elementAt(0);

    StaticData.theme = widget.theme;
    StaticData.darkTheme = widget.darkTheme;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.routerDelegate != null
      ? PlatformProvider(
          initialPlatform: widget.initialPlatform,
          settings: PlatformSettingsData(
            iosUsesMaterialWidgets: true,
            iosUseZeroPaddingForAppbarPlatformIcon: true,
          ),
          builder: (context) => PlatformApp.router(
            routerDelegate: widget.routerDelegate!,
            routeInformationParser: widget.routeInformationParser!,
            backButtonDispatcher: widget.backButtonDispatcher,
            routeInformationProvider: widget.routeInformationProvider,
            key: MitX.key,
            builder: defaultBuilder,
            title: widget.title,
            onGenerateTitle: widget.onGenerateTitle,
            color: widget.color,
            localizationsDelegates: widget.localizationsDelegates,
            localeListResolutionCallback: widget.localeListResolutionCallback,
            localeResolutionCallback: widget.localeResolutionCallback,
            supportedLocales: widget.supportedLocales,
            material: (context, platform) => MaterialAppRouterData(
              theme: StaticData.theme ?? widget.theme ?? ThemeData.fallback(),
              darkTheme: StaticData.darkTheme ??
                  widget.darkTheme ??
                  widget.theme ??
                  ThemeData.fallback(),
              themeMode: widget.themeMode,
              locale: MitX.locale ?? widget.locale,
              scaffoldMessengerKey: widget.scaffoldMessengerKey ??
                  StaticData.scaffoldMessengerKey,
              debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
              debugShowMaterialGrid: widget.debugShowMaterialGrid,
            ),
            cupertino: (context, platform) => CupertinoAppRouterData(
              locale: MitX.locale ?? widget.locale,
              debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
              routerDelegate: widget.routerDelegate!,
              routeInformationParser: widget.routeInformationParser!,
              backButtonDispatcher: widget.backButtonDispatcher,
              routeInformationProvider: widget.routeInformationProvider,
              theme: widget.cupertinoTheme,
              builder: defaultBuilder,
              title: widget.title,
              onGenerateTitle: widget.onGenerateTitle,
              color: widget.color,
              localizationsDelegates: widget.localizationsDelegates,
              localeListResolutionCallback: widget.localeListResolutionCallback,
              localeResolutionCallback: widget.localeResolutionCallback,
              supportedLocales: widget.supportedLocales,
              showPerformanceOverlay: widget.showPerformanceOverlay,
              checkerboardRasterCacheImages:
                  widget.checkerboardRasterCacheImages,
              checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
              showSemanticsDebugger: widget.showSemanticsDebugger,
              shortcuts: widget.shortcuts,
            ),
            showPerformanceOverlay: widget.showPerformanceOverlay,
            checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
            showSemanticsDebugger: widget.showSemanticsDebugger,
            debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
            shortcuts: widget.shortcuts,
            scrollBehavior: widget.scrollBehavior,
          ),
        )
      : PlatformApp(
          navigatorKey: MitX.key,
          home: widget.home,
          routes: widget.routes ?? const <String, WidgetBuilder>{},
          initialRoute: widget.initialRoute,
          onGenerateRoute:
              (widget.mitXPages != null ? generator : widget.onGenerateRoute),
          onGenerateInitialRoutes:
              (widget.mitXPages == null || widget.home != null)
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
          cupertino: (context, platform) => CupertinoAppData(
            locale: MitX.locale ?? widget.locale,
            debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
            theme: widget.cupertinoTheme,
            builder: defaultBuilder,
            title: widget.title,
            onGenerateTitle: widget.onGenerateTitle,
            color: widget.color,
            localizationsDelegates: widget.localizationsDelegates,
            localeListResolutionCallback: widget.localeListResolutionCallback,
            localeResolutionCallback: widget.localeResolutionCallback,
            supportedLocales: widget.supportedLocales,
            showPerformanceOverlay: widget.showPerformanceOverlay,
            checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
            showSemanticsDebugger: widget.showSemanticsDebugger,
            shortcuts: widget.shortcuts,
          ),
          title: widget.title,
          onGenerateTitle: widget.onGenerateTitle,
          color: widget.color,
          material: (context, platform) => MaterialAppData(
              theme: StaticData.theme ?? widget.theme ?? ThemeData.fallback(),
              darkTheme: StaticData.darkTheme ??
                  widget.darkTheme ??
                  widget.theme ??
                  ThemeData.fallback(),
              themeMode: widget.themeMode,
              locale: MitX.locale ?? widget.locale,
              scaffoldMessengerKey: widget.scaffoldMessengerKey ??
                  StaticData.scaffoldMessengerKey,
              debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
              debugShowMaterialGrid: widget.debugShowMaterialGrid),
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
          scrollBehavior: widget.scrollBehavior,
        );

  Widget defaultBuilder(BuildContext context, Widget? child) {
    return Directionality(
      textDirection: widget.textDirection ??
          (rtlLanguages.contains(MitX.locale?.languageCode)
              ? TextDirection.rtl
              : TextDirection.ltr),
      child: widget.builder == null
          ? (child ?? const Material())
          : widget.builder!(context, child ?? const Material()),
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
