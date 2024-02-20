import 'package:mit_x/mit_x.dart';

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
}
