import 'package:flutter/material.dart';
import 'package:mit_x/mit_x.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

extension TBIBNativeUIExtension on MitXInterface {
  void setFluentUITo(
      {bool macos = false,
      bool linux = false,
      bool windows = true,
      bool android = false}) {
    StaticData.macosFluent = macos;
    StaticData.linuxFluent = linux;
    StaticData.windowsFluent = windows;
    StaticData.androidFluent = android;
  }

  bool isFluentUITo() {
    return StaticData.macosFluent ||
        StaticData.linuxFluent ||
        StaticData.windowsFluent ||
        StaticData.androidFluent;
  }

  void showNativeSnackBar(
      {TextStyle? titleAlertStyle,
      TextStyle? messageStyle,
      Duration? duration,
      required String message,
      String? titleAlert,
      Color? backgroundColor,
      SnackBarAction? action,
      Animation<double>? animation,
      SnackBarBehavior? behavior,
      Clip clipBehavior = Clip.hardEdge,
      Color? closeIconColor,
      DismissDirection dismissDirection = DismissDirection.down,
      double? elevation,
      EdgeInsetsGeometry? margin,
      void Function()? onVisible,
      EdgeInsetsGeometry? padding,
      ShapeBorder? shape,
      bool? showCloseIcon,
      double? width,
      double? eve,
      Widget? customContent}) {
    SnackBar snackBar = SnackBar(
      backgroundColor: backgroundColor,
      action: action,
      animation: animation,
      behavior: behavior,
      clipBehavior: clipBehavior,
      closeIconColor: closeIconColor,
      dismissDirection: dismissDirection,
      elevation: elevation,
      margin: margin,
      onVisible: onVisible,
      padding: padding,
      shape: shape,
      showCloseIcon: showCloseIcon,
      width: width,
      content: customContent ??
          Column(children: [
            titleAlert != null
                ? Text(
                    titleAlert,
                    style: titleAlertStyle,
                  )
                : Container(),
            const SizedBox(height: 10),
            Text(
              message,
              style: messageStyle,
            )
          ]),
      duration: duration ?? const Duration(seconds: 3),
    );
    if (StaticData.windowsFluent ||
        StaticData.macosFluent ||
        StaticData.linuxFluent) {
      fluent.showSnackbar(MitX.context!, snackBar);
    } else {
      ScaffoldMessenger.of(MitX.context!).showSnackBar(snackBar);
    }
  }

  // Future<T?>? nativeBottomSheet<T>(Widget bottomsheet,
  //     {Color? backgroundColor,
  //     double? elevation,
  //     bool persistent = true,
  //     ShapeBorder? shape,
  //     Clip? clipBehavior,
  //     Color? barrierColor,
  //     bool? ignoreSafeArea,
  //     bool isScrollControlled = false,
  //     bool useRootNavigator = false,
  //     bool isDismissible = true,
  //     bool enableDrag = true,
  //     RouteSettings? settings,
  //     Duration? enterBottomSheetDuration,
  //     Duration? exitBottomSheetDuration,

  //     ///for fluent ui only (windows linux macos)
  //     Widget? header}) {
  //   if ( StaticData.windowsFluent ||  StaticData.macosFluent ||  StaticData.linuxFluent) {
  //     showBottomSheet<T>(
  //       context: MitX.context!,
  //       builder: (context) {
  //         return  fluent.BottomSheet(
  //           header: header,
  //           initialChildSize: ,
  //           description: const Text('Description or Details here'),
  //           children: const [
  //             // Usually a `ListTile` or `TappableListTile`
  //           ],
  //         );
  //       },
  //     );
  //     return null;
  //   } else {
  //     return Navigator.of(overlayContext!, rootNavigator: useRootNavigator)
  //         .push(MitXBottomSheetRoute<T>(
  //       builder: (_) => bottomsheet,
  //       isPersistent: persistent,
  //       // theme: Theme.of(key.currentContext, shadowThemeOnly: true),
  //       theme: Theme.of(key.currentContext!),
  //       isScrollControlled: isScrollControlled,

  //       barrierLabel: MaterialLocalizations.of(key.currentContext!)
  //           .modalBarrierDismissLabel,

  //       backgroundColor: backgroundColor ?? Colors.transparent,
  //       elevation: elevation,
  //       shape: shape,
  //       removeTop: ignoreSafeArea ?? true,
  //       clipBehavior: clipBehavior,
  //       isDismissible: isDismissible,
  //       modalBarrierColor: barrierColor,
  //       settings: settings,
  //       enableDrag: enableDrag,
  //       enterBottomSheetDuration:
  //           enterBottomSheetDuration ?? const Duration(milliseconds: 250),
  //       exitBottomSheetDuration:
  //           exitBottomSheetDuration ?? const Duration(milliseconds: 200),
  //     ));
  //   }
  // }
}
