import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier{
  int _currentIndex=1;

  PageController controller = PageController(initialPage: 1,/*keepPage: true*/);

  get currentIndex=> _currentIndex;

  set currentIndex(int index){
    print("Changed index to $index");
    _currentIndex=index;
    controller.animateToPage(currentIndex, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    notifyListeners();
  }
}