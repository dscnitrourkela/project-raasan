import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier{
  int _currentIndex=1;

  get currentIndex=> _currentIndex;

  set currentIndex(int index){
    print("Changed index to $index");
    _currentIndex=index;
    notifyListeners();
  }

}