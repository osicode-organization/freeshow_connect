import 'dart:io';

import 'package:freeshow_connect/src/domain/entity/port_status_entity.dart';

class PortStatus {
  final String host;
  final int port;

  PortStatus({required this.host, required this.port});
  Stream<PortStatusEntity> checkPortStatus({
    Duration interval = const Duration(seconds: 2),
    Duration timeout = const Duration(seconds: 1),
  }) async* {
    while (true) {
      final stopwatch = Stopwatch()..start();
      try {
        final socket = await Socket.connect(host, port, timeout: timeout);
        socket.destroy();
        // debugPrint('port is open');
        yield PortStatusEntity(
          isOpen: true,
          responseTime: stopwatch.elapsedMilliseconds,
          lastChecked: DateTime.now(),
        );
      } catch (e) {
        // debugPrint('port is error');
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
}
