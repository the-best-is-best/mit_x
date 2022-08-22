import 'package:flutter/material.dart';
import 'package:mit_x/src/keys/keys.dart';
import 'package:mit_x/mit_x.dart';

class MitXMaterialApp extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Widget? home;
  final Map<String, Widget Function(BuildContext)> routes;
  final String? initialRoute;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final Route<dynamic>? Function(RouteSettings)? onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers =
      const <NavigatorObserver>[];
  final String title;
  final String Function(BuildContext)? onGenerateTitle;
  final Color? color;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Iterable<Locale>? supportedLocales;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool useInheritedMediaQuery = false;
  final Translations? translations;
  final Locale? fallbackLocale;
  final Map<String, Map<String, String>>? translationsKeys;
  final TextDirection? textDirection;
  final TransitionBuilder? builder;

  const MitXMaterialApp(
      {Key? key,
      this.navigatorKey,
      this.scaffoldMessengerKey,
      this.home,
      this.initialRoute,
      this.onGenerateRoute,
      this.onGenerateInitialRoutes,
      this.onUnknownRoute,
      this.onGenerateTitle,
      this.color,
      this.theme,
      this.darkTheme,
      this.highContrastTheme,
      this.highContrastDarkTheme,
      this.locale,
      this.localizationsDelegates,
      this.localeListResolutionCallback,
      this.localeResolutionCallback,
      this.shortcuts,
      this.actions,
      this.restorationScopeId,
      this.scrollBehavior,
      required this.title,
      this.routes = const {},
      this.supportedLocales,
      this.translations,
      this.translationsKeys,
      this.textDirection,
      this.builder,
      this.fallbackLocale,
      this.debugShowMaterialGrid = false,
      this.showPerformanceOverlay = false,
      this.checkerboardRasterCacheImages = false,
      this.checkerboardOffscreenLayers = false,
      this.showSemanticsDebugger = false,
      this.debugShowCheckedModeBanner = false})
      : super(key: key);

  @override
  State<MitXMaterialApp> createState() => _MitXMartialAppState();
}

class _MitXMartialAppState extends State<MitXMaterialApp> {
  @override
  void initState() {
    if (Keys.martialAppKey != null) {
      super.initState();
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.locale != null) MitX.locale = widget.locale;
      if (widget.fallbackLocale != null) {
        MitX.fallbackLocale = widget.fallbackLocale;
      }
      if (widget.translations != null) {
        MitX.addTranslations(widget.translations!.keys);
      } else if (widget.translationsKeys != null) {
        MitX.addTranslations(widget.translationsKeys!);
      }
      if (widget.locale != null) MitX.changeLocale(widget.locale!);
    });
    Keys.martialAppKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: widget.routes,
      navigatorObservers: [
        ...widget.navigatorObservers,
      ],
      title: widget.title,
      navigatorKey: Keys.martialAppKey,
      scaffoldMessengerKey: widget.scaffoldMessengerKey,
      home: widget.home,
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
      onUnknownRoute: widget.onUnknownRoute,
      builder: defaultBuilder,
      onGenerateTitle: widget.onGenerateTitle,
      color: widget.color,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      themeMode: ThemesAndroid.getThemeMode,
      highContrastTheme: widget.highContrastTheme,
      highContrastDarkTheme: widget.highContrastDarkTheme,
      locale: MitX.locale ?? widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales:
          widget.supportedLocales ?? const <Locale>[Locale('en', 'US')],
      debugShowMaterialGrid: widget.debugShowMaterialGrid,
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
      actions: widget.actions,
      restorationScopeId: widget.restorationScopeId,
      scrollBehavior: widget.scrollBehavior,
      useInheritedMediaQuery: widget.useInheritedMediaQuery,
    );
  }

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
}
