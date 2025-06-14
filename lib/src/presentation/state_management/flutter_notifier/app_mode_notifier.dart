import 'package:flutter/cupertino.dart';

import '../../../../main.dart';

class AppModeNotifier extends ChangeNotifier {
  bool _appThemeStatus = appThemeMode;

  bool get switchThemeType => _appThemeStatus;

  set setAppThemeStatus(bool value) {
    _appThemeStatus = value;
    sharedPreferences.setBool(appThemeModeKey, _appThemeStatus);
    notifyListeners();
  }

  setAutomaticMode() {
    _appThemeStatus =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.light;
    sharedPreferences.setBool(appThemeModeKey, _appThemeStatus);
    notifyListeners();
  }

}
