import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier {
  int _currentIndex;
  PageController controller;

  BottomNavBarProvider({int initialPage}) {
    _currentIndex = initialPage ?? 1;
    controller = PageController(initialPage: initialPage??1, keepPage: true);
    print("value received at bottmna provider is $_currentIndex");
  }



  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    print("Changed index to $index");
    _currentIndex = index;
    controller.animateToPage(currentIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    notifyListeners();
  }
}
