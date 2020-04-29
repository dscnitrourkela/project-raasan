import 'package:flutter/material.dart';

bool isLoggedIn = false;
MediaQueryData mediaQueryData;
double scaleRatio = mediaQueryData.devicePixelRatio/2.002;
double screenHeight = mediaQueryData.size.height;
double screenWidth = mediaQueryData.size.width;

class LoginConfig {
  static double loginTextFieldWidth = 280 * scaleRatio;
  static double titleTextSize = 22 * scaleRatio;
}

class SignUpConfig{
  static double textFieldWidth = 275 * scaleRatio;
  static double raisedButtonWidth = 0.283 * screenWidth;
  static double raisedButtonHeight = 0.095 * screenWidth;
}

class OnBoardingConfig {
  static double illustrationWidth = 316.21 * scaleRatio;
  static double illustrationHeight = 280 * scaleRatio;
  static double footerTextSize = 14 * scaleRatio;
}

class BottomNavBarConfig {
  static double bottomNavBarHeight = (70 / 823) * screenHeight;
  static double bottomNavBarWidth = screenWidth;
  static double activeIconSize = (66 / 411) * screenWidth;
  static double inactiveIconSize = (24 / 411) * screenWidth;
  static double buttonPadding = 0.047 * screenWidth;
  static double buttonOffsetMultiplier = 0.196 * screenWidth;
  static double bottomPositioningValue = 0.271 * screenWidth;
  static double customPaintBottomPositionValue = 0.177 * screenWidth;
  static double customNavBarMaxHeight = 0.177 * screenWidth;
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
  static double lookingForPaddingBottom = (20 / 823) * screenHeight;


  static double categoryListHeight = (168 / 823) * screenHeight;
  static double categoryListWidth = (168 / 411) * screenWidth;
  static double categoryBoxHeight = (86 / 823) * screenHeight;
  static double categoryBoxWidth = (168 / 411) * screenWidth;
  static double categoryImageWidth=(144/411)*screenWidth;
  static double categoryImageHeight=(115/823)*screenHeight;

  static double productGridWidth = (180 / 823) * screenHeight;
  static double productGridHeight = (171 / 411) * screenHeight;
}

class CartConfig {

  static double checkoutButtonWidth=(106/411)*screenWidth;
  static double checkoutButtonHeight=(28/823)*screenHeight;

  static double imageWidth=(155/411)*screenWidth;
  static double imageHeight=(147/823)*screenHeight;

  static double counterHeight=(25.46/823)*screenHeight;
  static double counterWidth=(91/411)*screenWidth;

}
