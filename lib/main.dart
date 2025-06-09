import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freeshow_connect/dependency_injection/dependency_injection.dart';
import 'package:freeshow_connect/src/data/data_sources/get_initial_ip_address.dart';
import 'package:freeshow_connect/src/presentation/pages/base/base_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String ipAddressKey = "IP_ADDRESS_KEY";
late SharedPreferences sharedPreferences;
late String localIpAddress;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();

  String ip = await getPublicIP();
  if (ip != ipAddressError) {
    localIpAddress = ip;
  }
  localIpAddress = sharedPreferences.getString(ipAddressKey) ?? publicIpAddress;

  runApp(ProviderScope(child: const FreeshowConnectApp()));
}

class FreeshowConnectApp extends ConsumerStatefulWidget {
  const FreeshowConnectApp({super.key});

  @override
  ConsumerState<FreeshowConnectApp> createState() => _FreeshowConnectAppState();
}

class _FreeshowConnectAppState extends ConsumerState<FreeshowConnectApp> {
  @override
  void initState() {
    print('ip from app init $localIpAddress');
    // ref.read(ipAddressProvider).setLocalIpAdress = localIpAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.black,
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      home: const BasePage(),
    );
  }
}
