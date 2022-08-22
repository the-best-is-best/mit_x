import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mit_x/src/keys/keys.dart';
import 'package:mit_x/mit_x.dart';

class MitXCupertinoApp extends StatefulWidget {
  final Map<Type, Action<Intent>>? actions;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<String, Widget Function(BuildContext)>? routes;
  final String? initialRoute;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final Route<dynamic>? Function(RouteSettings)? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
//  final Widget Function(BuildContext, Widget?)? builder;
  final String title;
  final String Function(BuildContext)? onGenerateTitle;
  final Color? color;
  final CupertinoThemeData? theme;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Iterable<Locale>? supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final bool useInheritedMediaQuery;
  final Widget? home;
  final Translations? translations;
  final Locale? fallbackLocale;
  final Map<String, Map<String, String>>? translationsKeys;
  final TextDirection? textDirection;
  final TransitionBuilder? builder;
  const MitXCupertinoApp(
      {Key? key,
      this.navigatorKey,
      this.actions,
      this.builder,
      this.shortcuts,
      this.routes,
      this.initialRoute,
      this.onGenerateRoute,
      this.onGenerateInitialRoutes,
      this.onUnknownRoute,
      required this.title,
      this.onGenerateTitle,
      this.color,
      this.theme,
      this.locale,
      this.localizationsDelegates,
      this.localeListResolutionCallback,
      this.localeResolutionCallback,
      required this.supportedLocales,
      this.navigatorObservers,
      this.showPerformanceOverlay = false,
      this.checkerboardRasterCacheImages = false,
      this.checkerboardOffscreenLayers = false,
      this.showSemanticsDebugger = false,
      this.debugShowCheckedModeBanner = false,
      this.useInheritedMediaQuery = false,
      this.home,
      this.translations,
      this.fallbackLocale,
      this.translationsKeys,
      this.textDirection})
      : super(key: key);

  @override
  State<MitXCupertinoApp> createState() => _MitXCupertinoAppState();
}

class _MitXCupertinoAppState extends State<MitXCupertinoApp> {
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
    return CupertinoApp(
      actions: widget.actions,
      theme: widget.theme,
      navigatorKey: widget.navigatorKey,
      home: widget.home,
      routes: widget.routes ?? const <String, WidgetBuilder>{},
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
      onUnknownRoute: widget.onUnknownRoute,
      navigatorObservers:
          widget.navigatorObservers ?? const <NavigatorObserver>[],
      builder: defaultBuilder,
      title: widget.title,
      onGenerateTitle: widget.onGenerateTitle,
      color: widget.color,
      locale: MitX.locale ?? widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      localeListResolutionCallback: widget.localeListResolutionCallback,
      localeResolutionCallback: widget.localeResolutionCallback,
      supportedLocales: widget.supportedLocales ?? const [Locale('en', 'US')],
      showPerformanceOverlay: widget.showPerformanceOverlay,
      checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
      showSemanticsDebugger: widget.showSemanticsDebugger,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      shortcuts: widget.shortcuts,
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
