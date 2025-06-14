import 'package:flutter/cupertino.dart';
import 'package:freeshow_connect/src/presentation/pages/bitfocus/bitfocus_page.dart';
import 'package:freeshow_connect/src/presentation/pages/home/home_page.dart';
import 'package:freeshow_connect/src/presentation/pages/settings/settings_page.dart';
import 'package:icons_plus/icons_plus.dart';

import '../bible/bible_page.dart';
import '../projects/projects_page.dart';

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
          BottomNavigationBarItem(icon: Icon(HeroIcons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(HeroIcons.wrench_screwdriver),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(HeroIcons.book_open),
            label: 'Scriptures',
          ),
          BottomNavigationBarItem(icon: Icon(HeroIcons.cog), label: 'Settings'),
        ],
        activeColor: CupertinoColors.systemBlue,
        inactiveColor: CupertinoColors.inactiveGray,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const HomePage();
          case 1:
            return const ProjectsPage();
          case 2:
            return const BiblePage();
          case 3:
            return const SettingsPage();
          default:
            return const BitfocusPage();
        }
      },
    );
  }
}
