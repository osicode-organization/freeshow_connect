import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../core/bible_data.dart';
import '../models/bible_model.dart';

Bible bibleCall() {
  String jsonData = '''{
    "1 John": { "abr": "1Jn", "data": { "1": 10, "2": 29, "3": 24 }},
    "2 John": { "abr": "2Jn", "data": { "1": 13 }}
  }'''; // Truncated JSON example

  Map<String, dynamic> jsonMap = json.decode(bibleData);
  Bible bible = Bible.fromJson(jsonMap);

  print('1 John Abbreviation: ${bible.books["1 John"]?.abbreviation}');
  print('1 John Chapter 1 Verse Count: ${bible.books["1 John"]?.chapters[1]}');
  List<String> bookNames =
      bible.books.values.map((entry) => entry.abbreviation).toList();
  debugPrint(bookNames.toString());
  List<int> chapterCounts = bible.books["1 John"]?.chapters.keys.toList() ?? [];
  debugPrint("1 John is  ${chapterCounts.toString()}");
  int verseCount = bible.books["1 John"]?.chapters[1] ?? 0;
  debugPrint(
    "1 John is  ${chapterCounts.toString()} and verse count is $verseCount",
  );
  // bible.books.forEach((key, value) {});
  return bible;
}
