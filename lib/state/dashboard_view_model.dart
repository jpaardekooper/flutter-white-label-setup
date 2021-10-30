import 'package:flutter/material.dart';

class DashboardViewModel with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
