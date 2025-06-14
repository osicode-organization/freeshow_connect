import 'package:flutter/cupertino.dart';

class AppTheme {
  AppTheme._();

  static CupertinoThemeData light() {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemBlue,
      primaryContrastingColor: CupertinoColors.black,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      barBackgroundColor: CupertinoColors.extraLightBackgroundGray,
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.black,
        textStyle: TextStyle(
          fontFamily: 'Signika',
          color: CupertinoColors.black,
          fontSize: 18,
        ),
        actionTextStyle: TextStyle(fontFamily: 'Signika'),
        actionSmallTextStyle: TextStyle(fontFamily: 'Signika'),
      ),
    );
  }

  static CupertinoThemeData dark() {
    return CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: CupertinoColors.systemBlue.darkColor,
      primaryContrastingColor: CupertinoColors.white,
      scaffoldBackgroundColor: CupertinoColors.black,
      barBackgroundColor: CupertinoColors.darkBackgroundGray,
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.white,
        textStyle: TextStyle(
          fontFamily: 'Signika',
          color: CupertinoColors.white,
          fontSize: 18,
        ),
        actionTextStyle: TextStyle(fontFamily: 'Signika'),
        actionSmallTextStyle: TextStyle(fontFamily: 'Signika'),
      ),
    );
  }
}
