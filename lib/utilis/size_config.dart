import 'package:flutter/material.dart';

class SizeConfig {
  static double screenheight = 0.0;
  static double screenWidth = 0.0;
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
  }
  static double getProportionateHeight(double inputHeight) {
    return (inputHeight / 812) * screenheight;
  }
  static double getProportionateWidth(double inputWidth) {
    return (inputWidth / 375) * screenWidth;
  }
} 
// explain me flutter clean and flutter run like this 
// why we need to run the prigrsm in flutterr 
// why we choice i flutter by the way java is more 
// why required ths app beacuse we have multi;pwe app in this world 
