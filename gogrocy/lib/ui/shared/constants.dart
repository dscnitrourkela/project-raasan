import 'package:flutter/material.dart';

bool isLoggedIn = false;
MediaQueryData mediaQueryData;
double screenHeight = mediaQueryData.size.height;
double screenWidth = mediaQueryData.size.width;

class LoginSizeConfig {
  static double loginTextFieldWidth = 0.842 * screenWidth;
  static double loginTextFieldHeight = 0.842 * screenHeight;
  static double loginIllustrationWidth = 0.956 * screenWidth;
  static double loginIllustrationHeight = 0.384 * screenHeight;
}
