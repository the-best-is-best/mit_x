import 'dart:ui' as ui;

// import 'package:fluent_ui/fluent_ui.dart' as fluent;
// import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mit_x/mit_x.dart';
import 'package:mit_x/src/routes/custom_transition.dart';
import 'package:mit_x/src/routes/default_route.dart';
import 'package:mit_x/src/routes/delegate/get_router_delegate.dart';
import 'package:mit_x/src/routes/parse/get_information_parser.dart';
import 'package:mit_x/src/routes/parse/parse_route.dart';

/// It replaces the Flutter Navigator, but needs no context.
/// You can to use navigator.push(YourRoute()) rather
/// Navigator.push(context, YourRoute());
NavigatorState? get navigator => StaticData.navigateKey.currentState;

extension ExtensionBottomSheet on MitXInterface {
  Future<T?> bottomSheet<T>(
    Widget bottomsheet, {
    Color? backgroundColor,
    double? elevation,
    bool persistent = true,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool? ignoreSafeArea,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? settings,
    Duration? enterBottomSheetDuration,
    Duration? exitBottomSheetDuration,
  }) {
    return Navigator.of(overlayContext!, rootNavigator: useRootNavigator)
        .push(MitXBottomSheetRoute<T>(
      builder: (_) => bottomsheet,
      isPersistent: persistent,
      // theme: Theme.of(key.currentContext, shadowThemeOnly: true),
      theme: Theme.of(key.currentContext!),
      isScrollControlled: isScrollControlled,

      barrierLabel: MaterialLocalizations.of(key.currentContext!)
          .modalBarrierDismissLabel,

      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      shape: shape,
      removeTop: ignoreSafeArea ?? true,
      clipBehavior: clipBehavior,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      settings: settings,
      enableDrag: enableDrag,
      enterBottomSheetDuration:
          enterBottomSheetDuration ?? const Duration(milliseconds: 250),
      exitBottomSheetDuration:
          exitBottomSheetDuration ?? const Duration(milliseconds: 200),
    ));
  }
}

extension ExtensionDialog on MitXInterface {
  /// Show a dialog.
  /// You can pass a [transitionDuration] and/or [transitionCurve],
  /// overriding the defaults when the dialog shows up and closes.
  /// When the dialog closes, uses those animations in reverse.
  Future<T?> dialog<T>(
    Widget widget, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    assert(debugCheckHasMaterialLocalizations(context!));

    //  final theme = Theme.of(context, shadowThemeOnly: true);
    final theme = Theme.of(context!);
    return generalDialog<T>(
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        final pageChild = widget;
        Widget dialog = Builder(builder: (context) {
          return Theme(data: theme, child: pageChild);
        });
        if (useSafeArea) {
          dialog = SafeArea(child: dialog);
        }
        return dialog;
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context!).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? Colors.black54,
      transitionDuration: transitionDuration ?? defaultDialogTransitionDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: transitionCurve ?? defaultDialogTransitionCurve,
          ),
          child: child,
        );
      },
      navigatorKey: navigatorKey,
      routeSettings:
          routeSettings ?? RouteSettings(arguments: arguments, name: name),
    );
  }

  /// Api from showGeneralDialog with no context
  Future<T?> generalDialog<T>({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    GlobalKey<NavigatorState>? navigatorKey,
    RouteSettings? routeSettings,
  }) {
    assert(!barrierDismissible || barrierLabel != null);
    final nav = navigatorKey?.currentState ??
        Navigator.of(overlayContext!,
            rootNavigator:
                true); //overlay context will always return the root navigator
    return nav.push<T>(
      MitXDialogRoute<T>(
        pageBuilder: pageBuilder,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        settings: routeSettings,
      ),
    );
  }

  /// Custom UI Dialog.
  Future<T?> defaultDialog<T>({
    String title = "Alert",
    EdgeInsetsGeometry? titlePadding,
    TextStyle? titleStyle,
    Widget? content,
    EdgeInsetsGeometry? contentPadding,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onCustom,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    String? textCustom,
    Widget? confirm,
    Widget? cancel,
    Widget? custom,
    Color? backgroundColor,
    bool barrierDismissible = true,
    Color? buttonColor,
    String middleText = "Dialog made in 3 lines of code",
    TextStyle? middleTextStyle,
    double radius = 20.0,
    //   ThemeData themeData,
    List<Widget>? actions,

    // onWillPop Scope
    WillPopCallback? onWillPop,

    // the navigator used to push the dialog
    GlobalKey<NavigatorState>? navigatorKey,
    Key? key,
  }) {
    var leanCancel = onCancel != null || textCancel != null;
    var leanConfirm = onConfirm != null || textConfirm != null;
    actions ??= [];

    if (cancel != null) {
      actions.add(cancel);
    } else {
      if (leanCancel) {
        actions.add(TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: buttonColor ?? theme.colorScheme.secondary,
                    width: 2,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(100)),
          ),
          onPressed: () {
            onCancel?.call();
            back();
          },
          child: Text(
            textCancel ?? "Cancel",
            style: TextStyle(
                color: cancelTextColor ?? theme.colorScheme.secondary),
          ),
        ));
      }
    }
    if (confirm != null) {
      actions.add(confirm);
    } else {
      if (leanConfirm) {
        actions.add(TextButton(
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: buttonColor ?? theme.colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
            ),
            child: Text(
              textConfirm ?? "Ok",
              style: TextStyle(
                  color: confirmTextColor ?? theme.colorScheme.background),
            ),
            onPressed: () {
              onConfirm?.call();
            }));
      }
    }

    Widget baseAlertDialog = AlertDialog(
      key: key,
      titlePadding: titlePadding ?? const EdgeInsets.all(8),
      contentPadding: contentPadding ?? const EdgeInsets.all(8),

      backgroundColor: backgroundColor ?? theme.dialogBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      title: Text(title, textAlign: TextAlign.center, style: titleStyle),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          content ??
              Text(middleText,
                  textAlign: TextAlign.center, style: middleTextStyle),
          const SizedBox(height: 16),
          ButtonTheme(
            minWidth: 78.0,
            height: 34.0,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: actions,
            ),
          )
        ],
      ),
      // actions: actions, // ?? <Widget>[cancelButton, confirmButton],
      buttonPadding: EdgeInsets.zero,
    );

    return dialog<T>(
      onWillPop != null
          ? WillPopScope(
              onWillPop: onWillPop,
              child: baseAlertDialog,
            )
          : baseAlertDialog,
      barrierDismissible: barrierDismissible,
      navigatorKey: navigatorKey,
    );
  }
}

extension ExtensionSnackbar on MitXInterface {
  SnackbarController rawSnackbar({
    Key? key,
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Widget? icon,
    bool instantInit = true,
    bool shouldIconPulse = true,
    double? maxWidth,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(16),
    double borderRadius = 0.0,
    Color? borderColor,
    double borderWidth = 1.0,
    Color backgroundColor = const Color(0xFF303030),
    Color? leftBarIndicatorColor,
    List<BoxShadow>? boxShadows,
    Gradient? backgroundGradient,
    Widget? mainButton,
    OnTap? onTap,
    Duration? duration = const Duration(seconds: 3),
    bool isDismissible = true,
    DismissDirection? dismissDirection,
    bool showProgressIndicator = false,
    AnimationController? progressIndicatorController,
    Color? progressIndicatorBackgroundColor,
    Animation<Color>? progressIndicatorValueColor,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    SnackStyle snackStyle = SnackStyle.FLOATING,
    Curve forwardAnimationCurve = Curves.easeOutCirc,
    Curve reverseAnimationCurve = Curves.easeOutCirc,
    Duration animationDuration = const Duration(seconds: 1),
    SnackbarStatusCallback? snackbarStatus,
    double barBlur = 0.0,
    double overlayBlur = 0.0,
    Color? overlayColor,
    Form? userInputForm,
  }) {
    final getSnackBar = MitXSnackBar(
      key: key,
      snackbarStatus: snackbarStatus,
      title: title,
      message: message,
      titleText: titleText,
      messageText: messageText,
      snackPosition: snackPosition,
      borderRadius: borderRadius,
      margin: margin,
      duration: duration,
      barBlur: barBlur,
      backgroundColor: backgroundColor,
      icon: icon,
      shouldIconPulse: shouldIconPulse,
      maxWidth: maxWidth,
      padding: padding,
      borderColor: borderColor,
      borderWidth: borderWidth,
      leftBarIndicatorColor: leftBarIndicatorColor,
      boxShadows: boxShadows,
      backgroundGradient: backgroundGradient,
      mainButton: mainButton,
      onTap: onTap,
      isDismissible: isDismissible,
      dismissDirection: dismissDirection,
      showProgressIndicator: showProgressIndicator,
      progressIndicatorController: progressIndicatorController,
      progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
      progressIndicatorValueColor: progressIndicatorValueColor,
      snackStyle: snackStyle,
      forwardAnimationCurve: forwardAnimationCurve,
      reverseAnimationCurve: reverseAnimationCurve,
      animationDuration: animationDuration,
      overlayBlur: overlayBlur,
      overlayColor: overlayColor,
      userInputForm: userInputForm,
    );

    final controller = SnackbarController(getSnackBar);

    if (instantInit) {
      controller.show();
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        controller.show();
      });
    }
    return controller;
  }

  SnackbarController showSnackbar(MitXSnackBar snackbar) {
    final controller = SnackbarController(snackbar);
    controller.show();
    return controller;
  }

  SnackbarController snackbar(
    String title,
    String message, {
    Key? key,
    Color? colorText,
    Duration? duration = const Duration(seconds: 3),

    /// with instantInit = false you can put snackbar on initState
    bool instantInit = true,
    SnackPosition? snackPosition,
    Widget? titleText,
    Widget? messageText,
    Widget? icon,
    bool? shouldIconPulse,
    double? maxWidth,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    Color? backgroundColor,
    Color? leftBarIndicatorColor,
    List<BoxShadow>? boxShadows,
    Gradient? backgroundGradient,
    TextButton? mainButton,
    OnTap? onTap,
    bool? isDismissible,
    bool? showProgressIndicator,
    DismissDirection? dismissDirection,
    AnimationController? progressIndicatorController,
    Color? progressIndicatorBackgroundColor,
    Animation<Color>? progressIndicatorValueColor,
    SnackStyle? snackStyle,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration,
    double? barBlur,
    double? overlayBlur,
    SnackbarStatusCallback? snackbarStatus,
    Color? overlayColor,
    Form? userInputForm,
  }) {
    final getSnackBar = MitXSnackBar(
        key: key,
        snackbarStatus: snackbarStatus,
        titleText: titleText ??
            Text(
              title,
              style: TextStyle(
                color: colorText ?? iconColor ?? Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
        messageText: messageText ??
            Text(
              message,
              style: TextStyle(
                color: colorText ?? iconColor ?? Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
        snackPosition: snackPosition ?? SnackPosition.TOP,
        borderRadius: borderRadius ?? 15,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 10),
        duration: duration,
        barBlur: barBlur ?? 7.0,
        backgroundColor: backgroundColor ?? Colors.grey.withOpacity(0.2),
        icon: icon,
        shouldIconPulse: shouldIconPulse ?? true,
        maxWidth: maxWidth,
        padding: padding ?? const EdgeInsets.all(16),
        borderColor: borderColor,
        borderWidth: borderWidth,
        leftBarIndicatorColor: leftBarIndicatorColor,
        boxShadows: boxShadows,
        backgroundGradient: backgroundGradient,
        mainButton: mainButton,
        onTap: onTap,
        isDismissible: isDismissible ?? true,
        dismissDirection: dismissDirection,
        showProgressIndicator: showProgressIndicator ?? false,
        progressIndicatorController: progressIndicatorController,
        progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
        progressIndicatorValueColor: progressIndicatorValueColor,
        snackStyle: snackStyle ?? SnackStyle.FLOATING,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeOutCirc,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutCirc,
        animationDuration: animationDuration ?? const Duration(seconds: 1),
        overlayBlur: overlayBlur ?? 0.0,
        overlayColor: overlayColor ?? Colors.transparent,
        userInputForm: userInputForm);

    final controller = SnackbarController(getSnackBar);

    if (instantInit) {
      controller.show();
    } else {
      //routing.isSnackbar = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        controller.show();
      });
    }
    return controller;
  }
}

extension GetNavigation on MitXInterface {
  /// **Navigation.push()** shortcut.<br><br>
  ///
  /// Pushes a new `page` to the stack
  ///
  /// It has the advantage of not needing context,
  /// so you can call from your business logic
  ///
  /// You can set a custom [transition], and a transition [duration].
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Just like native routing in Flutter, you can push a route
  /// as a [fullscreenDialog],
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// If you want the same behavior of ios that pops a route when the user drag,
  /// you can set [popGesture] to true
  ///
  /// If you're using the [Bindings] api, you must define it here
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  Future<T?>? to<T>(
    dynamic page, {
    bool? opaque,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    int? id,
    String? routeName,
    bool fullscreenDialog = false,
    dynamic arguments,
    bool preventDuplicates = true,
    bool? popGesture,
    double Function(BuildContext context)? gestureWidth,
  }) {
    // var routeName = "/${page.runtimeType}";
    routeName ??= "/${page.runtimeType}";
    routeName = _cleanRouteName(routeName);
    if (preventDuplicates && routeName == currentRoute) {
      return null;
    }
    return global(id).currentState?.push<T>(
          GetPageRoute<T>(
            opaque: opaque ?? true,
            page: _resolvePage(page, 'to'),
            routeName: routeName,
            gestureWidth: gestureWidth,
            settings: RouteSettings(
              name: routeName,
              arguments: arguments,
            ),
            popGesture: popGesture ?? defaultPopGesture,
            transition: transition ?? defaultTransition,
            curve: curve ?? defaultTransitionCurve,
            fullscreenDialog: fullscreenDialog,
            transitionDuration: duration ?? defaultTransitionDuration,
          ),
        );
  }

  MitXPageBuilder _resolvePage(dynamic page, String method) {
    if (page is MitXPageBuilder) {
      return page;
    } else if (page is Widget) {
      MitX.log(
          '''WARNING, consider using: "MitX.$method(() => Page())" instead of "Get.$method(Page())".
Using a widget function instead of a widget fully guarantees that the widget and its controllers will be removed from memory when they are no longer used.
      ''');
      return () => page;
    } else if (page is String) {
      throw '''Unexpected String,
use toNamed() instead''';
    } else {
      throw '''Unexpected format,
you can only use widgets and widget functions here''';
    }
  }

  /// **Navigation.pushNamed()** shortcut.<br><br>
  ///
  /// Pushes a new named `page` to the stack.
  ///
  /// It has the advantage of not needing context, so you can call
  /// from your business logic.
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  ///
  /// Note: Always put a slash on the route ('/page1'), to avoid unnexpected errors
  Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    if (preventDuplicates && page == currentRoute) {
      return null;
    }

    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }

    return global(id).currentState?.pushNamed<T>(
          page,
          arguments: arguments,
        );
  }

  /// **Navigation.pushReplacementNamed()** shortcut.<br><br>
  ///
  /// Pop the current named `page` in the stack and push a new one in its place
  ///
  /// It has the advantage of not needing context, so you can call
  /// from your business logic.
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  ///
  /// Note: Always put a slash on the route ('/page1'), to avoid unnexpected errors
  Future<T?>? offNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    if (preventDuplicates && page == currentRoute) {
      return null;
    }

    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }
    return global(id).currentState?.pushReplacementNamed(
          page,
          arguments: arguments,
        );
  }

  /// **Navigation.popUntil()** shortcut.<br><br>
  ///
  /// Calls pop several times in the stack until [predicate] returns true
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// [predicate] can be used like this:
  /// `MitX.until((route) => MitX.currentRoute == '/home')`so when you get to home page,
  ///
  /// or also like this:
  /// `Get.until((route) => !Get.isDialogOpen())`, to make sure the
  /// dialog is closed
  void until(RoutePredicate predicate, {int? id}) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return global(id).currentState?.popUntil(predicate);
  }

  /// **Navigation.pushAndRemoveUntil()** shortcut.<br><br>
  ///
  /// Push the given `page`, and then pop several pages in the stack until
  /// [predicate] returns true
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// Obs: unlike other get methods, this one you need to send a function
  /// that returns the widget to the page argument, like this:
  /// Get.offUntil(GetPageRoute(page: () => HomePage()), predicate)
  ///
  /// [predicate] can be used like this:
  /// `Get.offUntil(page, (route) => (route as GetPageRoute).routeName == '/home')`
  /// to pop routes in stack until home,
  /// or also like this:
  /// `Get.until((route) => !Get.isDialogOpen())`, to make sure the dialog
  /// is closed
  Future<T?>? offUntil<T>(Route<T> page, RoutePredicate predicate, {int? id}) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return global(id).currentState?.pushAndRemoveUntil<T>(page, predicate);
  }

  /// **Navigation.pushNamedAndRemoveUntil()** shortcut.<br><br>
  ///
  /// Push the given named `page`, and then pop several pages in the stack
  /// until [predicate] returns true
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// [predicate] can be used like this:
  /// `Get.offNamedUntil(page, ModalRoute.withName('/home'))`
  /// to pop routes in stack until home,
  /// or like this:
  /// `Get.offNamedUntil((route) => !Get.isDialogOpen())`,
  /// to make sure the dialog is closed
  ///
  /// Note: Always put a slash on the route name ('/page1'), to avoid unexpected errors
  Future<T?>? offNamedUntil<T>(
    String page,
    RoutePredicate predicate, {
    int? id,
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }

    return global(id).currentState?.pushNamedAndRemoveUntil<T>(
          page,
          predicate,
          arguments: arguments,
        );
  }

  /// **Navigation.popAndPushNamed()** shortcut.<br><br>
  ///
  /// Pop the current named page and pushes a new `page` to the stack
  /// in its place
  ///
  /// You can send any type of value to the other route in the [arguments].
  /// It is very similar to `offNamed()` but use a different approach
  ///
  /// The `offNamed()` pop a page, and goes to the next. The
  /// `offAndToNamed()` goes to the next page, and removes the previous one.
  /// The route transition animation is different.
  Future<T?>? offAndToNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    dynamic result,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }
    return global(id).currentState?.popAndPushNamed(
          page,
          arguments: arguments,
          result: result,
        );
  }

  /// **Navigation.removeRoute()** shortcut.<br><br>
  ///
  /// Remove a specific [route] from the stack
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  void removeRoute(Route<dynamic> route, {int? id}) {
    return global(id).currentState?.removeRoute(route);
  }

  /// **Navigation.pushNamedAndRemoveUntil()** shortcut.<br><br>
  ///
  /// Push a named `page` and pop several pages in the stack
  /// until [predicate] returns true. [predicate] is optional
  ///
  /// It has the advantage of not needing context, so you can
  /// call from your business logic.
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [predicate] can be used like this:
  /// `Get.until((route) => Get.currentRoute == '/home')`so when you get to home page,
  /// or also like
  /// `Get.until((route) => !Get.isDialogOpen())`, to make sure the dialog
  /// is closed
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// Note: Always put a slash on the route ('/page1'), to avoid unexpected errors
  Future<T?>? offAllNamed<T>(
    String newRouteName, {
    RoutePredicate? predicate,
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: newRouteName, queryParameters: parameters);
      newRouteName = uri.toString();
    }

    return global(id).currentState?.pushNamedAndRemoveUntil<T>(
          newRouteName,
          predicate ?? (_) => false,
          arguments: arguments,
        );
  }

  /// Returns true if a Snackbar, Dialog or BottomSheet is currently OPEN
  bool get isOverlaysOpen =>
      (isSnackbarOpen || isDialogOpen! || isBottomSheetOpen!);

  /// Returns true if there is no Snackbar, Dialog or BottomSheet open
  bool get isOverlaysClosed =>
      (!isSnackbarOpen && !isDialogOpen! && !isBottomSheetOpen!);

  /// **Navigation.popUntil()** shortcut.<br><br>
  ///
  /// Pop the current page, snackbar, dialog or bottomsheet in the stack
  ///
  /// if your set [closeOverlays] to true, Get.back() will close the
  /// currently open snackbar/dialog/bottomsheet AND the current page
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// It has the advantage of not needing context, so you can call
  /// from your business logic.
  void back<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    // remove this code in version 5
    if (isSnackbarOpen && !closeOverlays) {
      closeCurrentSnackbar();
      return;
    }

    if (closeOverlays && isOverlaysOpen) {
      //TODO: This code brings compatibility of the new snackbar with GetX 4,
      // remove this code in version 5
      if (isSnackbarOpen) {
        closeAllSnackbars();
      }
      navigator?.popUntil((route) {
        return (!isDialogOpen! && !isBottomSheetOpen!);
      });
    }
    if (canPop) {
      if (global(id).currentState?.canPop() == true) {
        global(id).currentState?.pop<T>(result);
      }
    } else {
      global(id).currentState?.pop<T>(result);
    }
  }

  /// **Navigation.popUntil()** (with predicate) shortcut .<br><br>
  ///
  /// Close as many routes as defined by [times]
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  void close(int times, [int? id]) {
    if (times < 1) {
      times = 1;
    }
    var count = 0;
    var back = global(id).currentState?.popUntil((route) => count++ == times);

    return back;
  }

  /// **Navigation.pushReplacement()** shortcut .<br><br>
  ///
  /// Pop the current page and pushes a new `page` to the stack
  ///
  /// It has the advantage of not needing context,
  /// so you can call from your business logic
  ///
  /// You can set a custom [transition], define a Tween [curve],
  /// and a transition [duration].
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Just like native routing in Flutter, you can push a route
  /// as a [fullscreenDialog],
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// If you want the same behavior of ios that pops a route when the user drag,
  /// you can set [popGesture] to true
  ///
  /// If you're using the [Bindings] api, you must define it here
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  Future<T?>? off<T>(
    dynamic page, {
    bool opaque = false,
    Transition? transition,
    Curve? curve,
    bool? popGesture,
    int? id,
    String? routeName,
    dynamic arguments,
    bool fullscreenDialog = false,
    bool preventDuplicates = true,
    Duration? duration,
    double Function(BuildContext context)? gestureWidth,
  }) {
    routeName ??= "/${page.runtimeType.toString()}";
    routeName = _cleanRouteName(routeName);
    if (preventDuplicates && routeName == currentRoute) {
      return null;
    }
    return global(id).currentState?.pushReplacement(GetPageRoute(
        opaque: opaque,
        gestureWidth: gestureWidth,
        page: _resolvePage(page, 'off'),
        settings: RouteSettings(
          arguments: arguments,
          name: routeName,
        ),
        routeName: routeName,
        fullscreenDialog: fullscreenDialog,
        popGesture: popGesture ?? defaultPopGesture,
        transition: transition ?? defaultTransition,
        curve: curve ?? defaultTransitionCurve,
        transitionDuration: duration ?? defaultTransitionDuration));
  }

  ///
  /// Push a `page` and pop several pages in the stack
  /// until [predicate] returns true. [predicate] is optional
  ///
  /// It has the advantage of not needing context,
  /// so you can call from your business logic
  ///
  /// You can set a custom [transition], a [curve] and a transition [duration].
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Just like native routing in Flutter, you can push a route
  /// as a [fullscreenDialog],
  ///
  /// [predicate] can be used like this:
  /// `Get.until((route) => Get.currentRoute == '/home')`so when you get to home page,
  /// or also like
  /// `Get.until((route) => !Get.isDialogOpen())`, to make sure the dialog
  /// is closed
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// If you want the same behavior of ios that pops a route when the user drag,
  /// you can set [popGesture] to true
  ///
  /// If you're using the [Bindings] api, you must define it here
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  Future<T?>? offAll<T>(
    dynamic page, {
    RoutePredicate? predicate,
    bool opaque = false,
    bool? popGesture,
    int? id,
    String? routeName,
    dynamic arguments,
    bool fullscreenDialog = false,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    double Function(BuildContext context)? gestureWidth,
  }) {
    routeName ??= "/${page.runtimeType.toString()}";
    routeName = _cleanRouteName(routeName);
    return global(id).currentState?.pushAndRemoveUntil<T>(
        GetPageRoute<T>(
          opaque: opaque,
          popGesture: popGesture ?? defaultPopGesture,
          page: _resolvePage(page, 'offAll'),
          gestureWidth: gestureWidth,
          settings: RouteSettings(
            name: routeName,
            arguments: arguments,
          ),
          fullscreenDialog: fullscreenDialog,
          routeName: routeName,
          transition: transition ?? defaultTransition,
          curve: curve ?? defaultTransitionCurve,
          transitionDuration: duration ?? defaultTransitionDuration,
        ),
        predicate ?? (route) => false);
  }

  /// Takes a route [name] String generated by [to], [off], [offAll]
  /// (and similar context navigation methods), cleans the extra chars and
  /// accommodates the format.
  /// TODO: check for a more "appealing" URL naming convention.
  /// `() => MyHomeScreenView` becomes `/my-home-screen-view`.
  String _cleanRouteName(String name) {
    name = name.replaceAll('() => ', '');

    /// uncommonent for URL styling.
    // name = name.paramCase!;
    if (!name.startsWith('/')) {
      name = '/$name';
    }
    return Uri.tryParse(name)?.toString() ?? name;
  }

  /// change default config of Get
  void config(
      {bool? enableLog,
      bool? defaultPopGesture,
      bool? defaultOpaqueRoute,
      Duration? defaultDurationTransition,
      bool? defaultGlobalState,
      Transition? defaultTransition}) {
    if (defaultPopGesture != null) {
      StaticData.defaultPopGesture = defaultPopGesture;
    }
    if (defaultOpaqueRoute != null) {
      StaticData.defaultOpaqueRoute = defaultOpaqueRoute;
    }
    if (defaultTransition != null) {
      StaticData.defaultTransition = defaultTransition;
    }

    if (defaultDurationTransition != null) {
      StaticData.defaultTransitionDuration = defaultDurationTransition;
    }
  }

  Future<void> updateLocale(Locale l) async {
    MitX.locale = l;
    await forceAppUpdate();
  }

  /// As a rule, Flutter knows which widget to update,
  /// so this command is rarely needed. We can mention situations
  /// where you use const so that widgets are not updated with setState,
  /// but you want it to be forcefully updated when an event like
  /// language change happens. using context to make the widget dirty
  /// for performRebuild() is a viable solution.
  /// However, in situations where this is not possible, or at least,
  /// is not desired by the developer, the only solution for updating
  /// widgets that Flutter does not want to update is to use reassemble
  /// to forcibly rebuild all widgets. Attention: calling this function will
  /// reconstruct the application from the sketch, use this with caution.
  /// Your entire application will be rebuilt, and touch events will not
  /// work until the end of rendering.
  Future<void> forceAppUpdate() async {
    await engine.performReassemble();
  }

  void changeTheme(ThemeData theme) async {
    StaticData.setTheme(theme);
    await forceAppUpdate();
  }

  // void changeFluentTheme(fluent.FluentThemeData theme) async {
  //   StaticData.setFluentTheme(theme);
  //   await forceAppUpdate();
  // }

  // void changeMacTheme(macos.MacosThemeData theme) async {
  //   StaticData.setMacosTheme(theme);
  //   await forceAppUpdate();
  // }

  void changeThemeMode(ThemeMode themeMode) async {
    StaticData.setThemeMode(themeMode);
    await forceAppUpdate();
  }

  GlobalKey<NavigatorState>? addKey(GlobalKey<NavigatorState> newKey) {
    return StaticData.addKey(newKey);
  }

  GlobalKey<NavigatorState>? nestedKey(dynamic key) {
    keys.putIfAbsent(
      key,
      () => GlobalKey<NavigatorState>(
        debugLabel: 'MitX nested key: ${key.toString()}',
      ),
    );
    return keys[key];
  }

  GlobalKey<NavigatorState> global(int? k) {
    GlobalKey<NavigatorState> newKey;
    if (k == null) {
      newKey = key;
    } else {
      if (!keys.containsKey(k)) {
        throw 'Route id ($k) not found';
      }
      newKey = keys[k]!;
    }

    if (newKey.currentContext == null) {
      throw """You are trying to use contextless navigation without
      a MitXMaterialApp or MitX.key.
      you must exchange your [MaterialApp]
      for a [ MitXMaterialApp].
      """;
    }

    return newKey;
  }

  /// give current arguments
  dynamic get arguments => routing.args;

  /// give name from current route
  String get currentRoute => routing.current;

  /// give name from previous route
  String get previousRoute => routing.previous;

  /// check if snackbar is open
  bool get isSnackbarOpen =>
      SnackbarController.isSnackbarBeingShown; //routing.isSnackbar;

  void closeAllSnackbars() {
    SnackbarController.cancelAllSnackbars();
  }

  Future<void> closeCurrentSnackbar() async {
    await SnackbarController.closeCurrentSnackbar();
  }

  /// check if dialog is open
  bool? get isDialogOpen => routing.isDialog;

  /// check if bottomsheet is open
  bool? get isBottomSheetOpen => routing.isBottomSheet;

  /// check a raw current route
  Route<dynamic>? get rawRoute => routing.route;

  /// check if popGesture is enable
  bool get isPopGestureEnable => defaultPopGesture;

  /// check if default opaque route is enable
  bool get isOpaqueRouteDefault => defaultOpaqueRoute;

  /// give access to currentContext
  BuildContext? get context => key.currentContext;

  /// give access to current Overlay Context
  BuildContext? get overlayContext {
    BuildContext? overlay;
    key.currentState?.overlay?.context.visitChildElements((element) {
      overlay = element;
    });
    return overlay;
  }

  /// give access to Theme.of(context)
  ThemeData get theme {
    var theme = ThemeData.fallback();
    if (context != null) {
      theme = Theme.of(context!);
    }
    return theme;
  }

  ///The current [WidgetsBinding]
  WidgetsBinding get engine {
    return WidgetsFlutterBinding.ensureInitialized();
  }

  /// The window to which this binding is bound.
  ui.FlutterView get window => View.of(MitX.context!);

  Locale? get deviceLocale => window.platformDispatcher.locale;

  ///The number of device pixels for each logical pixel.
  double get pixelRatio => window.devicePixelRatio;

  Size get size => window.physicalSize / pixelRatio;

  ///The horizontal extent of this size.
  double get width => size.width;

  ///The vertical extent of this size
  double get height => size.height;

  ///The distance from the top edge to the first unpadded pixel,
  ///in physical pixels.
  double get statusBarHeight => window.padding.top;

  ///The distance from the bottom edge to the first unpadded pixel,
  ///in physical pixels.
  double get bottomBarHeight => window.padding.bottom;

  ///The system-reported text scale.
  double get textScaleFactor => window.platformDispatcher.textScaleFactor;

  /// give access to TextTheme.of(context)
  TextTheme get textTheme => theme.textTheme;

  /// give access to Mediaquery.of(context)
  MediaQueryData get mediaQuery => MediaQuery.of(context!);

  /// Check if dark mode theme is enable
  bool get isDarkMode => (theme.brightness == Brightness.dark);

  /// Check if dark mode theme is enable on platform on android Q+
  bool get isPlatformDarkMode =>
      (window.platformDispatcher.platformBrightness == Brightness.dark);

  /// give access to Theme.of(context).iconTheme.color
  Color? get iconColor => theme.iconTheme.color;

  FocusNode? get focusScope => FocusManager.instance.primaryFocus;

  GlobalKey<NavigatorState> get key => StaticData.navigateKey;

  Map<dynamic, GlobalKey<NavigatorState>> get keys => StaticData.keys;

  bool get defaultPopGesture => StaticData.defaultPopGesture;
  bool get defaultOpaqueRoute => StaticData.defaultOpaqueRoute;

  Transition? get defaultTransition => StaticData.defaultTransition;

  Duration get defaultTransitionDuration {
    return StaticData.defaultTransitionDuration;
  }

  Curve get defaultTransitionCurve => StaticData.defaultTransitionCurve;

  Curve get defaultDialogTransitionCurve {
    return StaticData.defaultDialogTransitionCurve;
  }

  Duration get defaultDialogTransitionDuration {
    return StaticData.defaultDialogTransitionDuration;
  }

  Routing get routing => StaticData.routing;

  Map<String, String?> get parameters => StaticData.parameters;
  set parameters(Map<String, String?> newParameters) =>
      StaticData.parameters = newParameters;

  CustomTransition? get customTransition => StaticData.customTransition;
  set customTransition(CustomTransition? newTransition) =>
      StaticData.customTransition = newTransition;

  void resetRootNavigator() {
    StaticData.keys = {};
  }

  Locale? getLocale() {
    return MitX.locale;
  }

  String? getLanguage() {
    return MitX.locale?.languageCode;
  }

  String? getCountry() {
    return MitX.locale?.countryCode;
  }

  Future<void> changeLocale(Locale newLocale) async {
    MitX.locale = newLocale;
    await forceAppUpdate();
  }

  Future<void> changeThemeApp() async {
    ThemeMode themeMode = ThemesAndroid.getThemeMode;
    themeMode = MitX.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    ThemesAndroid.seThemeMode = themeMode;
    await forceAppUpdate();
  }

  void openDrawer() {
    context?.openDrawer();
  }

  void closeDrawer() {
    context?.closeDrawer();
  }

  void openEndDrawer() {
    context?.openEndDrawer();
  }

  void closeEndDrawer() {
    context?.closeEndDrawer();
  }

  void saveForm() {
    StaticData.formKey.save();
  }

  bool isValidForm() {
    return StaticData.formKey.isValid();
  }

  void unFocusField() {
    context?.unFocusField();
  }

  GlobalKey<ScaffoldState> get scaffoldKey => StaticData.scaffoldKey;
  GlobalKey<FormState> get formKey => StaticData.formKey;
}

extension NavTwoExt on MitXInterface {
  void addPages(List<MitXPage> getPages) {
    routeTree.addRoutes(getPages);
  }

  void clearRouteTree() {
    _routeTree.routes.clear();
  }

  static final _routeTree = ParseRouteTree(routes: []);

  ParseRouteTree get routeTree => _routeTree;
  void addPage(MitXPage getPage) {
    routeTree.addRoute(getPage);
  }

  /// Casts the stored router delegate to a desired type
  TDelegate? delegate<TDelegate extends RouterDelegate<TPage>, TPage>() =>
      routerDelegate as TDelegate?;

  // // ignore: use_setters_to_change_properties
  // void setDefaultDelegate(RouterDelegate? delegate) {
  //   _routerDelegate = delegate;
  // }

  // GetDelegate? getDelegate() => delegate<GetDelegate, GetNavConfig>();

  GetInformationParser createInformationParser({String initialRoute = '/'}) {
    if (routeInformationParser == null) {
      return routeInformationParser = GetInformationParser(
        initialRoute: initialRoute,
      );
    } else {
      return routeInformationParser as GetInformationParser;
    }
  }

  // static GetDelegate? _delegate;

  GetDelegate get rootDelegate => createDelegate();

  GetDelegate createDelegate({
    MitXPage<dynamic>? notFoundRoute,
    List<NavigatorObserver>? navigatorObservers,
    TransitionDelegate<dynamic>? transitionDelegate,
    PopMode backButtonPopMode = PopMode.History,
    PreventDuplicateHandlingMode preventDuplicateHandlingMode =
        PreventDuplicateHandlingMode.ReorderRoutes,
  }) {
    if (routerDelegate == null) {
      return routerDelegate = GetDelegate(
        notFoundRoute: notFoundRoute,
        navigatorObservers: navigatorObservers,
        transitionDelegate: transitionDelegate,
        backButtonPopMode: backButtonPopMode,
        preventDuplicateHandlingMode: preventDuplicateHandlingMode,
      );
    } else {
      return routerDelegate as GetDelegate;
    }
  }
}

extension OverlayExt on MitXInterface {
  Future<T> showOverlay<T>({
    required Future<T> Function() asyncFunction,
    Color opacityColor = Colors.black,
    Widget? loadingWidget,
    double opacity = .5,
  }) async {
    final navigatorState =
        Navigator.of(MitX.overlayContext!, rootNavigator: false);
    final overlayState = navigatorState.overlay!;

    final overlayEntryOpacity = OverlayEntry(builder: (context) {
      return Opacity(
          opacity: opacity,
          child: Container(
            color: opacityColor,
          ));
    });
    final overlayEntryLoader = OverlayEntry(builder: (context) {
      return loadingWidget ??
          const Center(
              child: SizedBox(
            height: 90,
            width: 90,
            child: Text('Loading...'),
          ));
    });
    overlayState.insert(overlayEntryOpacity);
    overlayState.insert(overlayEntryLoader);

    T data;

    try {
      data = await asyncFunction();
    } on Exception catch (_) {
      overlayEntryLoader.remove();
      overlayEntryOpacity.remove();
      rethrow;
    }

    overlayEntryLoader.remove();
    overlayEntryOpacity.remove();
    return data;
  }
}
