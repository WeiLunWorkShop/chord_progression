import 'package:chord_progression/Controller/Settings.dart';
import 'package:chord_progression/Model/AppConstant.dart';
import 'package:chord_progression/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeatsContent extends StatelessWidget {
  final AppConstant instance;
  BeatsContent(this.instance);

  @override
  Widget build(BuildContext context) {
    List<String> beatsStyle = [
      "Blues Electro Funk Hip-Hop",
      "House Jazz Latin Techno"
    ];
    double settingsPanelHeight = 3 * instance.screenHeight / 4;
    double columnWidth = instance.screenWidth / 11;

    // ignore: missing_return
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      // ignore: close_sinks
      final settingsBloc = BlocProvider.of<SettingsBloc>(context);

      if (state is SettingsOnEvent) {
        return Container(
            decoration: BoxDecoration(
                color: instance.backgroundColor, border: instance.mainBorder),
            width: 9 * columnWidth,
            child: listViewItems(context, beatsStyle, columnWidth, 9,
                getButtonHeight(settingsPanelHeight, 4)));
      } else {
        settingsBloc.add(SettingsChangeEvent());
        return Container();
      }
    });
  }
}

double getButtonHeight(double height, int rowCount) {
  return (height / rowCount) - 10.0;
}

Widget listViewItems(BuildContext context, List<String> itemList,
    double columnWidth, int columnCount, double buttonHeight) {
  Color color = Color.fromRGBO(0, 255, 255, 0.8);
  var scrollState = itemList.length > 4
      ? AlwaysScrollableScrollPhysics()
      : NeverScrollableScrollPhysics();
  // ignore: close_sinks
  final settingsBloc = BlocProvider.of<SettingsBloc>(context);

  return ListView.builder(
      physics: scrollState,
      padding: const EdgeInsets.all(8),
      itemCount: itemList.length,
      itemBuilder: (BuildContext context, int index) {
        List<String> splitItem = itemList[index].split(" ");
        List<Widget> widgetList = new List<Widget>();

        for (var i in splitItem) {
          widgetList.add(InkWell(
            onTap: () {
              if (Settings.instance.currentBeats == i)
                Settings.instance.currentBeats = "";
              else
                Settings.instance.currentBeats = i;
              settingsBloc.add(SettingsChordButtonSelectEvent());
              // AudioManagement.instance
              //     .playDrumLoop(Settings.instance.currentBeats);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Settings.instance.currentBeats == i
                        ? Color.fromRGBO(0, 255, 255, 0.7)
                        : Colors.transparent,
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
