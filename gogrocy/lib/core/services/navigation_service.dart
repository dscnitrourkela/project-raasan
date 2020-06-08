import 'package:flutter/material.dart';
import 'package:gogrocy/ui/views/landing_page.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
  
  pushCart(){
    navigatorKey.currentState.push(MaterialPageRoute(builder: (context)=>HomePageView(startingPage: 0)));

  }


}
