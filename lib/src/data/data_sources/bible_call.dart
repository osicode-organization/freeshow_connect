import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/bible_model.dart';

Future<Bible> bibleCall() async {
  /*String jsonData = '''{
    "1 John": { "abr": "1Jn", "data": { "1": 10, "2": 29, "3": 24 }},
    "2 John": { "abr": "2Jn", "data": { "1": 13 }}
  }'''; */

  final String jsonString = await rootBundle.loadString(
    'assets/json/bibleData.json',
  );
  Map<String, dynamic> jsonMap = json.decode(jsonString); //bibleData
  Bible bible = Bible.fromJson(jsonMap);

  debugPrint('1 John Abbreviation: ${bible.books["1 John"]?.abbreviation}');
  debugPrint(
    '1 John Chapter 1 Verse Count: ${bible.books["1 John"]?.chapters.length}',
  );
  List<String> bookNames =
      bible.books.values.map((entry) => entry.abbreviation).toList();
  debugPrint(bookNames.toString());
  List<int> chapterCounts = bible.books["1 John"]?.chapters.keys.toList() ?? [];
  // debugPrint("1 John is  ${chapterCounts.toString()}");
  int verseCount = bible.books["1 John"]?.chapters[1] ?? 0;
  // debugPrint(
  //   "1 John is  ${chapterCounts.toString()} and verse count is $verseCount",
  // );
  String bookFromAbr =
      bible.books.values.firstWhere((test) => test.abbreviation == "2Jn").name;
  // debugPrint(bookFromAbr);

  // bible.books.forEach((key, value) {});
  return bible;
}
