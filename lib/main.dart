import 'package:flutter/cupertino.dart';
import 'package:freeshow_connect/src/presentation/pages/base/base_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const FreeshowConnectApp());
}

class FreeshowConnectApp extends StatelessWidget {
  const FreeshowConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemRed,
      ),
      home: const BasePage(),
    );
  }
}
