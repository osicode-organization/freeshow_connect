import 'package:cupertino_lists_enhanced/list_section.dart';
import 'package:cupertino_lists_enhanced/selection_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../dependency_injection/dependency_injection.dart';
import '../../widgets/my_show_cupertino_single_selection_page/my_show_cupertino_single_selection_page.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String appearanceValue = "Automatic";
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Settings')),
      child: ListView(
        children: [
          /* Appearance */
          EnhancedCupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile(
                title: const Text("Appearance"),
                additionalInfo: Text(appearanceValue),
                onTap: () async {
                  await myShowCupertinoSingleSelectionPage(
                    context: context,
                    title: const Text("Appearance"),
                    initial: appearanceValue,
                    selectedTrailingIcon: HeroIcons.check_circle,
                    onChanged: (newValue) {
                      setState(() {
                        appearanceValue = newValue!;
                      });
                      if (newValue == "Automatic") {
                        ref.read(appModeProvider).setAutomaticMode();
                      }
                      if (newValue == "Light") {
                        ref.read(appModeProvider).setAppThemeStatus = true;
                      }
                      if (newValue == "Dark") {
                        ref.read(appModeProvider).setAppThemeStatus = false;
                      }
                    },
                    children: [
                      SelectionItem<String>(
                        title: const Text("Automatic"),
                        value: "Automatic",
                      ),
                      SelectionItem<String>(
                        title: const Text("Light"),
                        value: "Light",
                      ),
                      SelectionItem<String>(
                        title: const Text("Dark"),
                        value: "Dark",
                      ),
                    ],
                  );
                },
                trailing: Icon(
                  HeroIcons.chevron_right,
                  size: CupertinoTheme.of(context).textTheme.textStyle.fontSize,
                  color: CupertinoColors.systemGrey2.resolveFrom(context),
                ),
              ),
            ],
          ),
          /*EnhancedCupertinoListSection.insetGrouped(
            // header: const Text("FULL SCREEN DIALOG"),
            // footer: const Text("Uses showCupertinoSingleSelectionPage to open a full page dialog to select an item."),
            headerType: CupertinoListSectionType.base,
            footerType: CupertinoListSectionType.base,
            children: [
              CupertinoListTile(
                title: const Text("Background App Refresh"),
                additionalInfo: Text(_routeValue ?? ""),
                onTap: () async {
                  await showCupertinoSingleSelectionPage(
                    context: context,
                    title: const Text("Background App Refresh"),
                    initial: _routeValue,
                    onChanged: (newValue) {
                      setState(() {
                        _routeValue = newValue;
                      });
                    },
                    header: const Text("BACKGROUND APP REFRESH"),
                    footer: const Text(
                      "Background app refresh requires an internet connection.",
                    ),
                    children: [
                      SelectionItem<String>(
                        title: const Text("Off"),
                        value: "Off",
                      ),
                      SelectionItem<String>(
                        title: const Text("Wi-Fi"),
                        value: "Wi-Fi",
                      ),
                      SelectionItem<String>(
                        title: const Text("Mobile Data"),
                        value: "Mobile Data",
                      ),
                    ],
                  );
                },
                trailing: const CupertinoListTileChevron(),
              ),
              CupertinoListTile(
                title: const Text("Background App Refresh"),
                additionalInfo: Text(_routeValue ?? ""),
                onTap: () async {
                  await showCupertinoSingleSelectionPage(
                    context: context,
                    title: const Text("Background App Refresh"),
                    initial: _routeValue,
                    onChanged: (newValue) {
                      setState(() {
                        _routeValue = newValue;
                      });
                    },
                    header: const Text("BACKGROUND APP REFRESH"),
                    footer: const Text(
                      "Background app refresh requires an internet connection.",
                    ),
                    children: [
                      SelectionItem<String>(
                        title: const Text("Off"),
                        value: "Off",
                      ),
                      SelectionItem<String>(
                        title: const Text("Wi-Fi"),
                        value: "Wi-Fi",
                      ),
                      SelectionItem<String>(
                        title: const Text("Mobile Data"),
                        value: "Mobile Data",
                      ),
                    ],
                  );
                },
                trailing: const CupertinoListTileChevron(),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
