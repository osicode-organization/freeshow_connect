import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../src/data/data_repository/get_calls_repository_impl.dart';
import '../src/data/data_repository/post_calls_repository_impl.dart';
import '../src/data/data_sources/check_port_status.dart';
import '../src/data/data_sources/post_calls.dart';
import '../src/domain/entity/port_status_entity.dart';
import '../src/presentation/state_management/flutter_notifier/app_mode_notifier.dart';
import '../src/presentation/state_management/flutter_notifier/bible_notifier.dart';
import '../src/presentation/state_management/flutter_notifier/ip_address_notifier.dart';
import '../src/presentation/state_management/flutter_notifier/project_notifier.dart';
import '../src/presentation/state_management/flutter_notifier/show_notifier.dart';

/// Change Notifiers
final ipAddressProvider = ChangeNotifierProvider<IpAddressNotifier>(
  (ref) => IpAddressNotifier(),
);

final showProvider = ChangeNotifierProvider<ShowNotifier>(
  (ref) => ShowNotifier(),
);

final projectProvider = ChangeNotifierProvider<ProjectNotifier>(
  (ref) => ProjectNotifier(),
);

final bibleProvider = ChangeNotifierProvider<BibleNotifier>(
  (ref) => BibleNotifier(),
);

final appModeProvider = ChangeNotifierProvider<AppModeNotifier>(
  (ref) => AppModeNotifier(),
);

/// Providers
final portStatusStreamProvider = StreamProvider<PortStatusEntity>((ref) {
  // debugPrint(' problem here?');
  return checkPortStatus(ref.watch(ipAddressProvider).localIP, 5505);
});

final postCallsProvider = Provider<PostCalls>(
  (ref) => PostCalls(ip: ref.watch(ipAddressProvider).localIP),
);

final postCallsRepositoryImplProvider = Provider<PostCallsRepositoryImpl>(
  (ref) =>
      PostCallsRepositoryImpl(postCallsInstance: ref.watch(postCallsProvider)),
);

final getCallsRepositoryImplProvider = Provider<GetCallsRepositoryImpl>(
  (ref) => GetCallsRepositoryImpl(),
);
