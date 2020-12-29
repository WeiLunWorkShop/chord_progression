import 'package:chord_progression/Model/AppConstant.dart';
import 'package:chord_progression/View/Settings/BeatsContent.dart';
import 'package:chord_progression/View/Settings/KeyContent.dart';
import 'package:flutter/material.dart';

class ContentView extends StatelessWidget {
  final AppConstant instance;
  final int action;

  ContentView(this.instance, this.action);

  @override
  Widget build(BuildContext context) {
    switch (action) {
      case 0:
      case 1:
        return KeyContent(instance);
        break;
      case 2:
        return BeatsContent(instance);
        break;
      default:
        return KeyContent(instance);
        break;
    }
  }
}
