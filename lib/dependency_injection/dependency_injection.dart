import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/data/data_sources/check_port_status.dart';
import '../src/domain/entity/port_status_entity.dart';
import '../src/presentation/state_management/flutter_notifier/ip_address_notifier.dart';

/// Change Notifiers
final ipAddressProvider = ChangeNotifierProvider<IpAddressNotifier>(
  (ref) => IpAddressNotifier(),
);

/// Providers
final portStatusStreamProvider = StreamProvider<PortStatusEntity>((ref) {
  // debugPrint(' problem here?');
  return checkPortStatus(ref.watch(ipAddressProvider).localIP, 5505);
});
