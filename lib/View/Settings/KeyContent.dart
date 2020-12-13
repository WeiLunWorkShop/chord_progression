import 'package:chord_progression/Controller/Settings.dart';
import 'package:flutter/material.dart';

Row keyContent(
    double screenWidth,
    double screenHeight,
    double panelLineWidth,
    Color borderColor,
    Color backgroundColor,
    Color mainColor,
    Border mainBorder) {
  // List
  const List<String> Notes = [
    "C C♯/D♭ D",
    "D♯/E♭ E F",
    "F♯/G♭ G G♯/A♭",
    "A A♯/B♭ B",
  ];

  const List<String> Keys = ["△", "-", "O", "+"];

  const List<String> Tensions = ["♭7 7", "♭9 9 ♯9", "11 ♯11", "♭13 13"];

  const List<String> Inversions = ["R", "1", "2", "3"];

  const List<String> Arpeggios = ["1", "2", "3", "4", "5", "6", "7", "8"];

  double settingsPanelHeight = 3 * screenHeight / 4;
  double columnWidth = screenWidth / 11;
  return Row(
    children: [
      // Notes
      Container(
          decoration: BoxDecoration(color: backgroundColor, border: mainBorder),
          width: 3 * columnWidth,
          child: listViewItems(
              Notes, columnWidth, 3, getButtonHeight(settingsPanelHeight, 4))),
      // Keys
      Container(
          decoration: BoxDecoration(color: backgroundColor, border: mainBorder),
          width: columnWidth,
          child: listViewItems(
              Keys, columnWidth, 1, getButtonHeight(settingsPanelHeight, 4))),
      // Tensions
      Container(
          decoration: BoxDecoration(color: backgroundColor, border: mainBorder),
          width: 3 * columnWidth,
          child: listViewItems(Tensions, columnWidth, 3,
              getButtonHeight(settingsPanelHeight, 4))),
      // Inversions
      Container(
          decoration: BoxDecoration(color: backgroundColor, border: mainBorder),
          width: columnWidth,
          child: listViewItems(Inversions, columnWidth, 1,
              getButtonHeight(settingsPanelHeight, 4))),
      // Arpeggios
      Container(
          decoration: BoxDecoration(
              border: Border.all(width: panelLineWidth, color: borderColor)),
          width: columnWidth,
          child: listViewItems(Arpeggios, columnWidth, 1,
              getButtonHeight(settingsPanelHeight, 4))),
    ],
  );
}

double getButtonHeight(double height, int rowCount) {
  return (height / rowCount) - 10.0;
}

Widget listViewItems(List<String> itemList, double columnWidth, int columnCount,
    double buttonHeight) {
  Color color = Color.fromRGBO(0, 255, 255, 0.8);
  var scrollState = itemList.length > 4
      ? AlwaysScrollableScrollPhysics()
      : NeverScrollableScrollPhysics();

  return ListView.builder(
      physics: scrollState,
      padding: const EdgeInsets.all(8),
      itemCount: itemList.length,
      itemBuilder: (BuildContext context, int index) {
        List<String> splitItem = itemList[index].split(" ");
        List<Widget> widgetList = new List<Widget>();

        for (var i in splitItem) {
          widgetList.add(InkWell(
            onTap: () => Settings.ButtonSelect(i),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: color, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                height: buttonHeight,
                width: ((columnCount * columnWidth) / splitItem.length) - 15.0,
                child: Center(
                    child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      text: i,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 25)),
                ))),
          ));
        }

        Widget wrapping = Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.end,
          spacing: 5.0,
          runSpacing: 5.0,
          children: widgetList,
        );

        return Container(
            //width: splitItem.length * columnWidth,
            child: Column(
          children: [
            wrapping,
            SizedBox(
              height: 5.0,
            ),
          ],
        ));
      });
}
