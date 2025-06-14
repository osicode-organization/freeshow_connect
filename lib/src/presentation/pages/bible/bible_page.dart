import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/src/either.dart';
import 'package:freeshow_connect/src/presentation/state_management/flutter_notifier/bible_notifier.dart';

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
  List<String> bibleListAbr = [];
  List<String> bibleListName = [];
  late Bible bible;
  String verseError = '';

  @override
  void initState() {
    super.initState();
    _scripturePageController = PageController();
    bible = bibleCall();
    bibleListAbr =
        bible.books.values.map((entry) => entry.abbreviation).toList();
    bibleListName = bible.books.values.map((entry) => entry.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    final localIp = ref.watch(ipAddressProvider);

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
                  /*  ------------------ Books ------------------- */
                  booksPage(chapters),
                  /*  ------------------ Chapters ------------------- */
                  chapterPage(scriptures, chapters),
                  /*  ------------------ Verses ------------------- */
                  versePage(scriptures, verses, localIp.connectionStatus),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget booksPage(List<int> chapters) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          /*  ------------------ Old Testament ------------------- */
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: bibleListAbr.length - 27,
              itemBuilder: (context, index) {
                String bookFromAbr =
                    bible.books.values
                        .firstWhere(
                          (test) => test.abbreviation == bibleListAbr[index],
                        )
                        .name;
                return GestureDetector(
                  key: Key(index.toString()),
                  onTap: () {
                    ref.read(bibleProvider.notifier).setSelectedSegment = 1;
                    _scripturePageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    ref.read(bibleProvider.notifier).setCurrentBook =
                        bookFromAbr;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ref.watch(appModeProvider).switchThemeType
                          ? CupertinoColors.systemGrey5
                          : CupertinoColors.systemGrey5.darkColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        bibleListAbr[index],
                        style: TextStyle(color: oldTestamentBibleColors(index)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          /*  ------------------ Divider ------------------- */
          Container(
            height: 3, // Thin line
            color: CupertinoColors.systemGrey, // iOS-style divider color
          ),
          /*  ------------------ New Testament ------------------- */
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: 27,
              itemBuilder: (context, index) {
                final bibleListNewTestament = bibleListAbr.sublist(
                  bibleListAbr.length - 27,
                );

                String bookFromAbr =
                    bible.books.values
                        .firstWhere(
                          (test) =>
                              test.abbreviation == bibleListNewTestament[index],
                        )
                        .name;
                return GestureDetector(
                  key: Key(index.toString()),
                  onTap: () {
                    ref.read(bibleProvider.notifier).setSelectedSegment = 1;
                    _scripturePageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    // get long bibleList[index]
                    ref.read(bibleProvider.notifier).setCurrentBook =
                        bookFromAbr;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ref.watch(appModeProvider).switchThemeType
                          ? CupertinoColors.systemGrey5
                          : CupertinoColors.systemGrey5.darkColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        bibleListNewTestament[index],
                        style: TextStyle(color: newTestamentBibleColors(index)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color oldTestamentBibleColors(int index) {
    if (index < 5) {
      return Color(0xffD34F73);
    } else if (index >= 5 && index < 17) {
      return Color(0xff23ad32);
    } else if (index >= 17 && index < 22) {
      return Color(0xff19647E);
    } else if (index >= 22 && index < 27) {
      return Color(0xff66101F);
    } else {
      return Color(0xff5941A9);
    }
  }

  Color newTestamentBibleColors(int index) {
    if (index < 4) {
      return Color(0xffF26157);
    } else if (index >= 4 && index < 5) {
      return Color(0xff23ad32);
    } else if (index >= 5 && index < 19) {
      return Color(0xff027BCE);
    } else if (index >= 19 && index < 26) {
      return Color(0xff66101F);
    } else {
      return Color(0xff136F63);
    }
  }

  Padding chapterPage(BibleNotifier scriptures, List<int> chapters) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(scriptures.currentBook),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  key: Key(index.toString()),
                  onTap: () {
                    ref.read(bibleProvider.notifier).setSelectedSegment = 2;
                    _scripturePageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    ref.read(bibleProvider.notifier).setCurrentChapter =
                        chapters[index];
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          ref.watch(appModeProvider).switchThemeType
                              ? CupertinoColors.systemGrey5
                              : CupertinoColors.systemGrey5.darkColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text(chapters[index].toString())),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding versePage(
    BibleNotifier scriptures,
    List<int> verses,
    bool connectionStatus,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /*  ------------------ Previous scripture ------------------- */
              CupertinoButton(
                onPressed:
                    scriptures.currentVerse == verses.first
                        ? null
                        : () async {
                          final info =
                              await ref
                                  .read(postCallsRepositoryImplProvider)
                                  .previousScripture();
                          scriptureFailure(info);
                          ref.read(bibleProvider.notifier).decrementVerse();
                        },
                child: Icon(CupertinoIcons.chevron_back),
              ),
              Text(
                "${scriptures.currentBook} ${scriptures.currentChapter.toString()}:${scriptures.currentVerse.toString()}",
              ),
              /*  ------------------ Next scripture ------------------- */
              CupertinoButton(
                onPressed:
                    scriptures.currentVerse == verses.last
                        ? null
                        : () async {
                          final info =
                              await ref
                                  .read(postCallsRepositoryImplProvider)
                                  .nextScripture();
                          scriptureFailure(info);
                          ref.read(bibleProvider.notifier).incrementVerse();
                        },
                disabledColor: CupertinoColors.inactiveGray,
                child: Icon(CupertinoIcons.chevron_forward),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: verses.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  key: Key(index.toString()),
                  onTap: () async {
                    ref.read(bibleProvider.notifier).setCurrentVerse =
                        verses[index];

                    int bookNumber = bibleListName.indexOf(
                      scriptures.currentBook,
                    );
                    debugPrint(scriptures.currentBook);
                    debugPrint(
                      "${(bookNumber + 1).toString()}.${scriptures.currentChapter.toString()}.${scriptures.currentVerse.toString()}",
                    );

                    final info = await ref
                        .read(postCallsRepositoryImplProvider)
                        .startScripture(
                          "${(bookNumber + 1).toString()}.${scriptures.currentChapter.toString()}.${scriptures.currentVerse.toString()}",
                        );
                    scriptureFailure(info);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          ref.watch(appModeProvider).switchThemeType
                              ? CupertinoColors.systemGrey5
                              : CupertinoColors.systemGrey5.darkColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text(verses[index].toString())),
                  ),
                );
              },
            ),
          ),
          if (!connectionStatus)
            Text(
              verseError,
              style: TextStyle(color: CupertinoColors.systemRed),
            ),
        ],
      ),
    );
  }

  void scriptureFailure(Either<String, void> info) => info.match((failure) {
    setState(() {
      verseError = failure;
    });
  }, (data) {});
}
