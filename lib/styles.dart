import 'package:flutter/cupertino.dart';

abstract class ThemeColor {
  static const CupertinoDynamicColor text =
      CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.black, darkColor: CupertinoColors.white);

  static const CupertinoDynamicColor backGround =
      CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white, darkColor: CupertinoColors.black);
}
