import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/bottom_appbar_provider.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var provider=Provider.of<BottomNavBarProvider>(context);
    return FancyBottomNavigation(
      barBackgroundColor: Colors.black,
      inactiveIconColor: Colors.grey,
      textColor: Colors.white,
      tabs: [
        TabData(iconData: Icons.shopping_cart, title: "Cart"),
        TabData(iconData: Icons.home, title: "Home"),
        TabData(iconData: Icons.account_circle, title: "Account")
      ], onTabChangedListener: (int position) {

        provider.currentIndex=position;
    },


    );
  }


}