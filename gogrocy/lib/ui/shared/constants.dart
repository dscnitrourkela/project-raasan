import 'package:flutter/material.dart';

bool isLoggedIn = false;
MediaQueryData mediaQueryData;
double screenHeight = mediaQueryData.size.height;
double screenWidth = mediaQueryData.size.width;

class LoginConfig {
  static double textFieldWidth = 0.842 * screenWidth;
  static double textFieldHeight = 0.842 * screenHeight;
  static double illustrationWidth = 0.956 * screenWidth;
  static double illustrationHeight = 0.384 * screenHeight;
}
