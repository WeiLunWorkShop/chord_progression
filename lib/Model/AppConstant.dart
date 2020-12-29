import 'package:chord_progression/Controller/AudioManagement.dart';
import 'package:flutter/material.dart';

class AppConstant {
  double screenWidth;
  double screenHeight;
  double panelLineWidth;
  Color borderColor;
  Color backgroundColor;
  Color mainColor;
  Border mainBorder;
  AudioManagement audioManagement;

  AppConstant(screenWidth, screenHeight, panelLineWidth, borderColor,
      backgroundColor, mainColor, mainBorder, audioManagement) {
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
    this.panelLineWidth = panelLineWidth;
    this.borderColor = borderColor;
    this.backgroundColor = backgroundColor;
    this.mainColor = mainColor;
    this.mainBorder = mainBorder;
    this.audioManagement = audioManagement;
  }
}
