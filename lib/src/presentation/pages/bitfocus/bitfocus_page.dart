import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../data/data_sources/get_calls.dart';
import '../../../data/data_sources/post_calls.dart';
import '../../../data/models/projects_models/projects_model.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class BitfocusPage extends StatefulWidget {
  const BitfocusPage({super.key});

  @override
  State<BitfocusPage> createState() => _BitfocusPageState();
}

class _BitfocusPageState extends State<BitfocusPage> {
  List<ProjectsModel> projectsList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? _value;
    if (projectsList.isEmpty) {
      _value = 'project';//projectsList[0].name;
    }
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Bitfocus Companion'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GutterExtraLarge(),
            Text('Get shows'),
            CupertinoButton(
              onPressed: () async {
                await getShow();
              },
              color: CupertinoColors.systemIndigo,
              child: const Text('Get shows'),
            ),
            GutterExtraLarge(),
            Text('Get projects'),
            CupertinoButton(
              onPressed: () async {
                final projects = await getProjects();
                setState(() {
                  projectsList = projects;
                });
              },
              color: CupertinoColors.systemRed,
              child: const Text('Get projects'),
            ),
            GutterMedium(),
            // CupertinoSegmentedControl(
            //   children: children,
            //   onValueChanged: onValueChanged,
            // ),
            if (projectsList.isNotEmpty)
              CupertinoSlidingSegmentedControl(
                children: {
                  for (var item in projectsList) item.projectName: Text(item.projectName),
                },
                onValueChanged: (String? value) {
                  setState(() {
                    _value = value;
                  });
                },
                groupValue: _value,
              ),
            Wrap(
              children: [
                ...projectsList.map(
                  (toElement) => SizedBox(
                    height: 50,
                    width: 150,
                    child: GestureDetector(
                      onTap: () async {
                        await selectProjectByName(toElement.projectName);
                      },
                      child: Card(child: Center(child: Text(toElement.projectName))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
