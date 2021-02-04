import 'package:chord_progression/Controller/Settings.dart';
import 'package:chord_progression/Model/AppConstant.dart';
import 'package:chord_progression/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum contentType { notes, keys, tensions, inversions, arpeggios }

class KeyContent extends StatelessWidget {
  final AppConstant instance;
  KeyContent(this.instance);

  @override
  Widget build(BuildContext context) {
    double settingsPanelHeight = 3 * instance.screenHeight / 4;
    double columnWidth = instance.screenWidth / 11;

    // List
    const List<String> Notes = [
      "C C♯/D♭ D",
      "D♯/E♭ E F",
      "F♯/G♭ G G♯/A♭",
      "A A♯/B♭ B",
    ];

    // ignore: non_constant_identifier_names
    List<String> Keys = ["Maj", "Min", "Dim", "Aug", "5th", "8ve"];

    const List<String> TrebleTensions = [
      "♭7 7",
      "♭9 9 ♯9",
      "11 ♯11",
      "♭13 13",
      "♭2 2 ♯2",
      "4 ♯4",
      "♭6 6"
    ];

    const List<String> BassTensions = [
      "♭7 7",
      "♭9 9 ♯9",
      "11 ♯11",
      "♭13 13",
    ];

    const List<String> Inversions = ["R", "1", "2"];

    const List<String> Arpeggios = ["1", "2", "3", "4", "5", "6", "7", "8"];

    // ignore: missing_return
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      // ignore: close_sinks
      final settingsBloc = BlocProvider.of<SettingsBloc>(context);

      if (Settings.instance.currentSettingsAction == 0 &&
          Settings.instance.chordList[Settings.instance.currentChordIndex]
                  .trebleInversion ==
              '2') Keys.removeLast();

      if (state is SettingsOnEvent) {
        return Row(
          children: [
            // Notes
            Container(
                decoration: BoxDecoration(
                    color: instance.backgroundColor,
                    border: instance.mainBorder),
                width: 3 * columnWidth,
                child: listViewItems(
                    context,
                    Notes,
                    columnWidth,
                    3,
                    getButtonHeight(settingsPanelHeight, 4),
                    contentType.notes.index)),
            // Keys
            Container(
                decoration: BoxDecoration(
                    color: instance.backgroundColor,
                    border: instance.mainBorder),
                width: columnWidth,
                child: listViewItems(
                    context,
                    Keys,
                    columnWidth,
                    1,
                    getButtonHeight(settingsPanelHeight, 4),
                    contentType.keys.index)),
            // Tensions
            Container(
                decoration: BoxDecoration(
                    color: instance.backgroundColor,
                    border: instance.mainBorder),
                width: 3 * columnWidth,
                child: listViewItems(
                    context,
                    Settings.instance.currentSettingsAction == 0
                        ? TrebleTensions
                        : BassTensions,
                    columnWidth,
                    3,
                    getButtonHeight(settingsPanelHeight, 4),
                    contentType.tensions.index)),
            // Inversions
            Container(
                decoration: BoxDecoration(
                    color: instance.backgroundColor,
                    border: instance.mainBorder),
                width: columnWidth,
                child: listViewItems(
                    context,
                    Inversions,
                    columnWidth,
                    1,
                    getButtonHeight(settingsPanelHeight, 4),
                    contentType.inversions.index)),
            // Arpeggios
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: instance.panelLineWidth,
                        color: instance.borderColor)),
                width: columnWidth,
                child: listViewItems(
                    context,
                    Arpeggios,
                    columnWidth,
                    1,
                    getButtonHeight(settingsPanelHeight, 4),
                    contentType.arpeggios.index)),
          ],
        );
      } else {
        settingsBloc.add(SettingsChangeEvent());
        return Container();
      }
    });
  }

  double getButtonHeight(double height, int rowCount) {
    return (height / rowCount) - 10.0;
  }

  ListView listViewItems(
      BuildContext context,
      List<String> itemList,
      double columnWidth,
      int columnCount,
      double buttonHeight,
      int contentType) {
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
          int currentChordIndex = Settings.instance.currentPlayState == 2
              ? Settings.instance.tempChordIndex
              : Settings.instance.currentChordIndex;
          String currentSelect;
          List<String> currentTension = new List<String>();

          // treble
          if (Settings.instance.currentSettingsAction == 0) {
            switch (contentType) {
              case 0:
                // notes
                currentSelect =
                    Settings.instance.chordList[currentChordIndex].trebleNote;
                break;
              case 1:
                // keys
                currentSelect =
                    Settings.instance.chordList[currentChordIndex].trebleKey;
                break;
              case 2:
                // tensions
                currentTension = Settings
                    .instance.chordList[currentChordIndex].trebleTension;
                break;
              case 3:
                // inversions
                currentSelect = Settings
                    .instance.chordList[currentChordIndex].trebleInversion;
                break;
              case 4:
                // arpeggios
                currentSelect = Settings
                    .instance.chordList[currentChordIndex].trebleArpeggios;
                break;
              default:
                break;
            }
          }
          // bass
          else {
            switch (contentType) {
              case 0:
                // notes
                currentSelect =
                    Settings.instance.chordList[currentChordIndex].bassNote;
                break;
              case 1:
                // keys
                currentSelect =
                    Settings.instance.chordList[currentChordIndex].bassKey;
                break;
              case 2:
                // tensions
                currentTension =
                    Settings.instance.chordList[currentChordIndex].bassTension;
                break;
              case 3:
                // inversions
                currentSelect = Settings
                    .instance.chordList[currentChordIndex].bassInversion;
                break;
              case 4:
                // arpeggios
                currentSelect = Settings
                    .instance.chordList[currentChordIndex].bassArpeggios;
                break;
              default:
                break;
            }
          }

          for (var i in splitItem) {
            widgetList.add(
              InkWell(
                onTap: () {
                  setButton(contentType, i);
                  settingsBloc.add(SettingsChordButtonSelectEvent());
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: contentType == 2
                            ? getButtonColor(
                                isTension: true,
                                button: i,
                                selectList: currentTension)
                            : getButtonColor(
                                isTension: false,
                                button: i,
                                select: currentSelect),
                        border: Border.all(color: color, width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    height: buttonHeight,
                    width:
                        ((columnCount * columnWidth) / splitItem.length) - 15.0,
                    child: Center(
                        child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: i,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: color,
                              fontSize: 20)),
                    ))),
              ),
            );
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
}

Color getButtonColor(
    {@required bool isTension,
    String button,
    String select,
    List<String> selectList}) {
  if (isTension)
    return selectList.isEmpty
        ? Colors.transparent
        : (selectList.contains(button)
            ? Color.fromRGBO(0, 255, 255, 0.7)
            : Colors.transparent);
  else
    return button == select
        ? Color.fromRGBO(0, 255, 255, 0.7)
        : Colors.transparent;
}

void setButton(int type, String button) {
  int currentChordIndex = Settings.instance.currentPlayState == 2
      ? Settings.instance.tempChordIndex
      : Settings.instance.currentChordIndex;
  if (Settings.instance.currentSettingsAction == 0) {
    switch (type) {
      case 0:
        // notes
        Settings.instance.chordList[currentChordIndex].trebleNote =
            Settings.instance.chordList[currentChordIndex].trebleNote == button
                ? ""
                : button;
        break;
      case 1:
        // keys
        Settings.instance.chordList[currentChordIndex].trebleKey = button;
        break;
      case 2:
        // tensions
        tensionSelect(true, button);
        break;
      case 3:
        // inversions
        Settings.instance.chordList[currentChordIndex].trebleInversion = button;
        break;
      case 4:
        // arpeggios
        Settings.instance.chordList[currentChordIndex].trebleArpeggios = button;
        break;
      default:
        break;
    }
  }
  // bass
  else {
    switch (type) {
      case 0:
        // notes
        Settings.instance.chordList[currentChordIndex].bassNote =
            Settings.instance.chordList[currentChordIndex].bassNote == button
                ? ""
                : button;
        break;
      case 1:
        // keys
        Settings.instance.chordList[currentChordIndex].bassKey = button;
        break;
      case 2:
        // tensions
        tensionSelect(false, button);
        break;
      case 3:
        // inversions
        Settings.instance.chordList[currentChordIndex].bassInversion = button;
        break;
      case 4:
        // arpeggios
        Settings.instance.chordList[currentChordIndex].bassArpeggios = button;
        break;
      default:
        break;
    }
  }
}

void tensionSelect(bool isTreble, String select) {
  // check player play state
  int currentChordIndex = Settings.instance.currentPlayState == 2
      ? Settings.instance.tempChordIndex
      : Settings.instance.currentChordIndex;

  if (isTreble) {
    if (Settings.instance.chordList[currentChordIndex].trebleTension
        .contains(select))
      Settings.instance.chordList[currentChordIndex].trebleTension
          .remove(select);
    else if (Settings
            .instance.chordList[currentChordIndex].trebleTension.length >=
        2) {
      Settings.instance.chordList[currentChordIndex].trebleTension.removeLast();
      Settings.instance.chordList[currentChordIndex].trebleTension.add(select);
    } else
      Settings.instance.chordList[currentChordIndex].trebleTension.add(select);
  } else {
    if (Settings.instance.chordList[currentChordIndex].bassTension
        .contains(select))
      Settings.instance.chordList[currentChordIndex].bassTension.remove(select);
    else if (Settings
            .instance.chordList[currentChordIndex].bassTension.length >=
        2) {
      Settings.instance.chordList[currentChordIndex].bassTension.removeLast();
      Settings.instance.chordList[currentChordIndex].bassTension.add(select);
    } else
      Settings.instance.chordList[currentChordIndex].bassTension.add(select);
  }
}
