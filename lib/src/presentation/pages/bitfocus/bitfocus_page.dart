import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:freeshow_connect/src/data/data_sources/bible_call.dart';

import '../../../data/data_sources/get_calls.dart';
import '../../../data/data_sources/post_calls.dart';
import '../../../data/models/all_projects_models/all_projects_model.dart';

class BitfocusPage extends StatefulWidget {
  const BitfocusPage({super.key});

  @override
  State<BitfocusPage> createState() => _BitfocusPageState();
}

class _BitfocusPageState extends State<BitfocusPage> {
  List<AllProjectsModel> projectsList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? value;
    if (projectsList.isEmpty) {
      value = 'project'; //projectsList[0].name;
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
            Text('Get bible'),
            CupertinoButton(
              onPressed: ()  {
                bibleCall();
              },
              color: CupertinoColors.systemIndigo,
              child: const Text('Get bible'),
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
                  for (var item in projectsList)
                    item.projectName: Text(item.projectName),
                },
                onValueChanged: (String? value) {
                  setState(() {
                    value = value;
                  });
                },
                groupValue: value,
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
                      child: Card(
                        child: Center(child: Text(toElement.projectName)),
                      ),
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
