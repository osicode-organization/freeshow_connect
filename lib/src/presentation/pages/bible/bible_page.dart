import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../dependency_injection/dependency_injection.dart';
import '../../../data/data_sources/bible_call.dart';
import '../../../data/models/bible_model.dart';

class BiblePage extends ConsumerStatefulWidget {
  const BiblePage({super.key});

  @override
  ConsumerState<BiblePage> createState() => _BiblePageState();
}

class _BiblePageState extends ConsumerState<BiblePage> {
  final Map<int, Widget> segments = {
    0: Text("Book"),
    1: Text("Chapter"),
    2: Text("Verse"),
  };
  late PageController _scripturePageController;
  List<String> bibleList = [];
  late Bible bible;

  @override
  void initState() {
    super.initState();
    _scripturePageController = PageController();
    bible = bibleCall();
    bibleList = bible.books.values.map((entry) => entry.abbreviation).toList();
  }

  @override
  Widget build(BuildContext context) {
    final scriptures = ref.watch(bibleProvider);
    List<int> chapters =
        bible.books[scriptures.currentBook]?.chapters.keys.toList() ?? [];
    int verseCount =
        bible.books[scriptures.currentBook]?.chapters[scriptures
            .currentChapter] ??
        0;
    List<int> verses = List.generate(verseCount, (index) => index + 1);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Scriptures")),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoSlidingSegmentedControl<int>(
              groupValue: scriptures.selectedSegment,
              children: segments,
              onValueChanged: (int? newValue) {
                ref.read(bibleProvider.notifier).setSelectedSegment = newValue!;
                _scripturePageController.animateToPage(
                  newValue,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
            Expanded(
              child: PageView(
                controller: _scripturePageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: bibleList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          key: Key(index.toString()),
                          onTap: () {
                            ref
                                .read(bibleProvider.notifier)
                                .setSelectedSegment = 1;
                            _scripturePageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                            // get lonng bibleList[index]
                            ref.read(bibleProvider.notifier).setCurrentVerse =
                                chapters[index];
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey5,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text(bibleList[index])),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(scriptures.currentBook),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                            itemCount: chapters.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                key: Key(index.toString()),
                                onTap: () {
                                  ref
                                      .read(bibleProvider.notifier)
                                      .setSelectedSegment = 2;
                                  _scripturePageController.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                  ref
                                      .read(bibleProvider.notifier)
                                      .setCurrentVerse = chapters[index];
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey5,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(chapters[index].toString()),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "${scriptures.currentBook} ${scriptures.currentChapter.toString()}",
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                            itemCount: verses.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                key: Key(index.toString()),
                                onTap: () {
                                  ref
                                      .read(bibleProvider.notifier)
                                      .setCurrentVerse = verses[index];
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey5,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(verses[index].toString()),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
