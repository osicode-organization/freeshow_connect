import 'package:flutter/cupertino.dart';

class ShowNotifier extends ChangeNotifier {
  String _showId = '';
  String get showId => _showId;
  String _layoutId = '';
  String get layoutId => _layoutId;
  int _currentSlide = 1;
  int get currentSlide => _currentSlide;
  int _totalSlides = -1;
  int get totalSlides => _totalSlides;
  set setShowId(String id) {
    _showId = id;
    notifyListeners();
  }

  set setLayoutId(String id) {
    _layoutId = id;
    notifyListeners();
  }

  set setCurrentSlide(int slide) {
    _currentSlide = slide;
    notifyListeners();
  }

  set setTotalSlides(int slides) {
    _totalSlides = slides;
    debugPrint('total slide is $_totalSlides');
    notifyListeners();
  }

  increaseCurrentSlide() {
    _currentSlide++;
    notifyListeners();
  }

  decreaseCurrentSlide() {
    _currentSlide--;
    notifyListeners();
  }
}
