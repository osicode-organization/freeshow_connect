import 'package:flutter/cupertino.dart';

import '../../../../main.dart';

class IpAddressNotifier extends ChangeNotifier {
  bool _connectionStatus = false;

  String _localIpAddress = localIpAddress;

  String get localIP => _localIpAddress;
  bool get connectionStatus => _connectionStatus;

  set setLocalIpAddress(String ip) {
    sharedPreferences.setString(ipAddressKey, ip);
    _localIpAddress = ip;
    debugPrint('new ip address $_localIpAddress');
    notifyListeners();
  }

  setConnectionStatus(bool status) {
    _connectionStatus = status;
    notifyListeners();
  }
}
