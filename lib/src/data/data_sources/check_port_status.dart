import 'dart:io';

import 'package:freeshow_connect/src/domain/entity/port_status_entity.dart';

Stream<PortStatusEntity> checkPortStatus(
  String host,
  int port, {
  Duration interval = const Duration(seconds: 2),
  Duration timeout = const Duration(seconds: 1),
}) async* {
  while (true) {
    final stopwatch = Stopwatch()..start();
    try {
      final socket = await Socket.connect(host, port, timeout: timeout);
      socket.destroy();
      yield PortStatusEntity(
        isOpen: true,
        responseTime: stopwatch.elapsedMilliseconds,
        lastChecked: DateTime.now(),
      );
    } catch (e) {
      yield PortStatusEntity(
        isOpen: false,
        error: e.toString(),
        lastChecked: DateTime.now(),
      );
    }
    stopwatch.stop();
    await Future.delayed(interval);
  }
}
