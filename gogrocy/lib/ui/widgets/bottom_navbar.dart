import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
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
    return CurvedNavigationBar(
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
      buttonBackgroundColor: Colors.lightGreen,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeOut,
      animationDuration: Duration(milliseconds: 400),
      onTap: (index) {
        provider.currentIndex = index;
      },
    );
  }
}
