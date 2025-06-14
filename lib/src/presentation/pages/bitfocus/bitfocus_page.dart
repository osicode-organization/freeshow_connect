import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freeshow_connect/dependency_injection/dependency_injection.dart';
import 'package:freeshow_connect/src/data/data_sources/bible_call.dart';

import '../../../domain/entity/all_projects_entity/all_projects_entity.dart';

class BitfocusPage extends ConsumerStatefulWidget {
  const BitfocusPage({super.key});

  @override
  ConsumerState<BitfocusPage> createState() => _BitfocusPageState();
}

class _BitfocusPageState extends ConsumerState<BitfocusPage> {
  List<AllProjectsEntity> projectsList = [];
  String projectListError = '';
  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchData() async {
    final info =
        await ref.read(getCallsRepositoryImplProvider).callGetProjects();
    info.match(
      (failure) {
        setState(() {
          projectListError = failure;
        });
      },
      (data) {
        setState(() {
          projectsList = data;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? value;
    if (projectsList.isEmpty) {
      value = 'project'; //projectsList[0].name;
    }
    final providePostCalls = ref.watch(postCallsProvider);
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
              onPressed: () {
                bibleCall();
              },
              color: CupertinoColors.systemIndigo,
              child: const Text('Get bible'),
            ),
            GutterExtraLarge(),
            Text('Get projects'),
            CupertinoButton(
              onPressed: () async {
                debugPrint('callGetProjects');
                await ref
                    .watch(getCallsRepositoryImplProvider)
                    .callGetProjects(); //fetchData();
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
                        await ref
                            .read(postCallsProvider)
                            .selectProjectByName(toElement.projectName);
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
