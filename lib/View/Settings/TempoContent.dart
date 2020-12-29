import 'package:chord_progression/Model/AppConstant.dart';
import 'package:flutter/material.dart';

class TempoContent extends StatelessWidget {
  final AppConstant instance;
  TempoContent(this.instance);

  @override
  Widget build(BuildContext context) {
    double columnWidth = instance.screenWidth / 11;

    return Container(
        height: 3 * instance.screenHeight / 4,
        width: 9 * columnWidth,
        child: Row(children: [
          Container(
            height: instance.screenHeight / 3,
            width: 3 * columnWidth,
            child: IconButton(
              icon: Icon(Icons.remove),
              color: instance.mainColor,
              iconSize: 80.0,
              onPressed: () {},
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(0, 255, 255, 0.8), width: 3),
                  borderRadius: BorderRadius.circular(12)),
              height: instance.screenHeight / 3,
              width: 3 * columnWidth,
              child: Center(
                  child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text: "120BPM",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: instance.mainColor,
                        fontSize: 35)),
              ))),
          Container(
            height: instance.screenHeight / 3,
            width: 3 * columnWidth,
            child: IconButton(
              icon: Icon(Icons.add),
              color: instance.mainColor,
              iconSize: 80.0,
              onPressed: () {},
            ),
          ),
        ]));
  }
}
