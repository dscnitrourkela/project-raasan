import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/bottom_appbar_provider.dart';
import 'package:gogrocy/ui/widgets/navbar/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var provider = Provider.of<BottomNavBarProvider>(context);
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
    
    
    /*CurvedNavigationBar(
      //key: _bottomNavigationKey,
      index: 0,
      height: constants.BottomNavBarConfig.bottomNavBarHeight,
      items: <Widget>[
        Icon(
          Icons.shopping_cart,
          size: constants.BottomNavBarConfig.inactiveIconSize,
          color: Colors.white,
        ),
        Icon(
          Icons.explore,
          size: constants.BottomNavBarConfig.inactiveIconSize,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          size: constants.BottomNavBarConfig.inactiveIconSize,
          color: Colors.white,
        ),
      ],
      color: Colors.black,
      buttonBackgroundColor: colors.PRIMARY_COLOR,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeOut,
      animationDuration: Duration(milliseconds: 400),
      onTap: (index) {
        provider.currentIndex = index;
      },
    );*/
  }
}
