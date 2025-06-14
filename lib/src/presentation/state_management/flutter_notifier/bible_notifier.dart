import 'package:flutter/cupertino.dart';

class BibleNotifier extends ChangeNotifier {
  String _currentBook = 'Genesis';
  String get currentBook => _currentBook;
  set setCurrentBook(String value) {
    _currentBook = value;
    notifyListeners();
  }

  int _currentChapter = 1;
  int get currentChapter => _currentChapter;
  set setCurrentChapter(int value) {
    _currentChapter = value;
    notifyListeners();
  }

  int _currentVerse = 1;
  int get currentVerse => _currentVerse;
  set setCurrentVerse(int value) {
    _currentVerse = value;
    debugPrint('Current verse: $_currentVerse');
    notifyListeners();
  }

  incrementVerse() {
    _currentVerse++;
    notifyListeners();
  }

  decrementVerse() {
    _currentVerse--;
    notifyListeners();
  }

  int _selectedSegment = 0;
  int get selectedSegment => _selectedSegment;
  set setSelectedSegment(int value) {
    _selectedSegment = value;
    notifyListeners();
  }
}
