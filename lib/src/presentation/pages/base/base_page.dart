import 'package:flutter/cupertino.dart';
import 'package:freeshow_connect/src/presentation/pages/bitfocus/bitfocus_page.dart';
import 'package:freeshow_connect/src/presentation/pages/home/home_page.dart';
import 'package:freeshow_connect/src/presentation/pages/settings/settings_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
        activeColor: CupertinoColors.systemBlue,
        inactiveColor: CupertinoColors.inactiveGray,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const HomePage();
          case 1:
            return const BitfocusPage();
          case 2:
            return const SettingsPage();
          default:
            return const HomePage();
        }
      },
    );
  }
}
