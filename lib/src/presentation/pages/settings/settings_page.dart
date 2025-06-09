import 'package:flutter/cupertino.dart';
// import 'package:cupertino_lists_enhanced/cupertino_lists_enhanced.dart';
import 'package:cupertino_lists_enhanced/app_type.dart';
import 'package:cupertino_lists_enhanced/list_section.dart';
import 'package:cupertino_lists_enhanced/list_tile.dart';
import 'package:cupertino_lists_enhanced/multi_selection.dart';
import 'package:cupertino_lists_enhanced/route.dart';
import 'package:cupertino_lists_enhanced/selection.dart';
import 'package:cupertino_lists_enhanced/selection_item.dart';
import 'package:cupertino_lists_enhanced/selection_tile.dart';
import 'package:cupertino_lists_enhanced/single_selection.dart';
import 'package:cupertino_lists_enhanced/widget_location.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _routeValue = "Wi-Fi";
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Settings')),
      child: ListView(
          children: [
            // EnhancedListTile(),
            EnhancedCupertinoListSection.insetGrouped(
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
                        footer: const Text("Background app refresh requires an internet connection."),
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
                        ]
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
                        footer: const Text("Background app refresh requires an internet connection."),
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
                        ]
                    );
                  },
                  trailing: const CupertinoListTileChevron(),
                )
              ],
            ),
            CupertinoListTile(
              backgroundColor: CupertinoColors.white,
              title: Text('Appearance'),
              trailing: Icon(CupertinoIcons.right_chevron,color: CupertinoColors.systemGrey),
            ),
          ],
        ),
    );
  }
}
