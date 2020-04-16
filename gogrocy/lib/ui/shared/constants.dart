import 'package:flutter/material.dart';

bool isLoggedIn = false;
MediaQueryData mediaQueryData;
double screenHeight = mediaQueryData.size.height;
double screenWidth = mediaQueryData.size.width;

class LoginConfig {
  static double loginTextFieldWidth = 0.842 * screenWidth;
  static double loginTextFieldHeight = 0.842 * screenHeight;
  static double loginIllustrationWidth = 0.956 * screenWidth;
  static double loginIllustrationHeight = 0.384 * screenHeight;
}

class BottomNavBarConfig {
  static double bottomNavBarHeight = 0.0842 * screenHeight;
  static double bottomNavBarWidth = screenWidth;
}

class AppBarConfig {
  static double appBarHeight = 0.1008 * screenHeight;
  static double appBarWidth = screenWidth;
  static double titleFontSize = 0.0267 * screenHeight;
  static double searchIconSize = 0.5 * appBarHeight;
  static double searchIconPaddingRight = 0.0827 * screenWidth;
  static double addressTitleFontSize = 0.144 * appBarHeight;
  static double addressFontSize = 0.184 * appBarHeight;
  static double addressPaddingLeft = 0.06326034063 * screenWidth;
}

class HomePageConfig {
  static double carouselHeight = 0.3827 * screenHeight;
  static double carouselIndicatorFactor = 1.31;
  static double carouselIndicatorWidth = (11.83 / 411) * screenWidth;
  static double carouselIndicatorHeight = (3.6 / 823) * screenHeight;
  static double indicatorPaddingTop = (25 / 823) * screenHeight;

  static double viewAllButtonWidth = (53.2 / 411) * screenWidth;
  static double viewAllButtonHeight = (25.89 / 823) * screenHeight;

  static double lookingForPaddingTop = (37 / 823) * screenHeight;
  static double lookingForPaddingBottom = (37 / 823) * screenHeight;

  static double categoryListHeight = (168 / 823) * screenHeight;
  static double categoryListWidth = (168 / 411) * screenWidth;
  static double categoryBoxHeight = (86 / 823) * screenHeight;
  static double categotyBoxWidth = (168 / 411) * screenWidth;

  static double productGridWidth = (171 / 823) * screenHeight;
  static double productGridHeight = (171 / 411) * screenHeight;
}
