import 'package:flutter/material.dart';

class AppConstant {
  double screenWidth;
  double screenHeight;
  double panelLineWidth;
  Color borderColor;
  Color backgroundColor;
  Color mainColor;
  Border mainBorder;

  AppConstant(screenWidth, screenHeight, panelLineWidth, borderColor,
      backgroundColor, mainColor, mainBorder) {
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
    this.panelLineWidth = panelLineWidth;
    this.borderColor = borderColor;
    this.backgroundColor = backgroundColor;
    this.mainColor = mainColor;
    this.mainBorder = mainBorder;
  }
}
