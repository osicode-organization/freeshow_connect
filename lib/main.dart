import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freeshow_connect/src/config/app_theme/app_theme.dart';
import 'package:freeshow_connect/src/data/data_sources/get_initial_ip_address.dart';
import 'package:freeshow_connect/src/domain/entity/port_status_entity.dart';
import 'package:freeshow_connect/src/presentation/pages/base/base_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dependency_injection/dependency_injection.dart';

const String ipAddressKey = "IP_ADDRESS_KEY";
late SharedPreferences sharedPreferences;
final String publicIpAddress = '0.0.0.0';
const String ipAddressError = 'ERROR';
late String localIpAddress;

const String appThemeModeKey = "APP_THEME_MODE";

late bool appThemeMode;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  appThemeMode = sharedPreferences.getBool(appThemeModeKey) ?? true;

  /*late String? publicIp;
  String ip = await getPublicIP();
  if (ip != ipAddressError) {
    publicIp = ip;
  }
  localIpAddress =
      sharedPreferences.getString(ipAddressKey) ?? publicIp ?? publicIpAddress;*/
  localIpAddress =
      sharedPreferences.getString(ipAddressKey) ?? publicIpAddress;

  runApp(ProviderScope(child: const FreeshowConnectApp()));
}

class FreeshowConnectApp extends ConsumerStatefulWidget {
  const FreeshowConnectApp({super.key});

  @override
  ConsumerState<FreeshowConnectApp> createState() => _FreeshowConnectAppState();
}

class _FreeshowConnectAppState extends ConsumerState<FreeshowConnectApp> {
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<PortStatusEntity>>(portStatusStreamProvider, (
      previous,
      next,
    ) {
      next.when(
        data: (status) {
          ref
              .read(ipAddressProvider.notifier)
              .setConnectionStatus(status.isOpen);
        },
        loading: () {
          // Optional: Handle loading state updates
        },
        error: (err, stack) {
          // Optional: Handle error state updates
          ref.read(ipAddressProvider.notifier).setConnectionStatus(false);
        },
      );
    });
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(appModeProvider).switchThemeType ? AppTheme.light() : AppTheme.dark(),
      home: const BasePage(),
    );
  }
}
