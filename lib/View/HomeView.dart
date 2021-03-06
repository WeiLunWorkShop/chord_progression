import 'package:chord_progression/Controller/Settings.dart';
import 'package:chord_progression/Model/AppConstant.dart';
import 'package:chord_progression/Model/ChordObject.dart';
import 'package:chord_progression/View/ContentView.dart';
import 'package:chord_progression/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum actions {
  treble,
  bass,
  beats,
  tempo,
}

class _MyHomePageState extends State<MyHomePage> {
  List<ChordObject> chordList = new List<ChordObject>();

  Future<void> _addChord() async {
    setState(() {
      Settings.instance.chordList.add(new ChordObject());
      Settings.instance.currentChordIndex =
          Settings.instance.chordList.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Screen State
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double panelLineWidth = 2;
    Color borderColor = Colors.grey;
    Color backgroundColor = Colors.black;
    Color mainColor = Color.fromRGBO(0, 255, 255, 1);

    Border mainBorder = Border(
        top: BorderSide(width: panelLineWidth, color: borderColor),
        left: BorderSide(width: panelLineWidth, color: borderColor),
        bottom: BorderSide(width: panelLineWidth, color: borderColor));

    AppConstant appConstant = new AppConstant(screenWidth, screenHeight,
        panelLineWidth, borderColor, backgroundColor, mainColor, mainBorder);

    // ignore: missing_return
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      int currentChordSelected = Settings.instance.currentPlayState == 2
          ? Settings.instance.tempChordIndex
          : Settings.instance.currentChordIndex;

      if (state is SettingsOnEvent) {
        return Scaffold(
            body: Column(
          children: [
            // Chords Panel
            Container(
              height: screenHeight / 4,
              width: screenWidth,
              color: Colors.blueGrey[900],
              child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: Settings.instance.chordList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () =>
                                Settings.instance.chordSelect(context, index),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(179, 136, 255, 0.8),
                                        width: 1)),
                                height: screenHeight / 4,
                                width: screenHeight / 4,
                                child: Column(
                                  children: [
                                    Container(
                                      color: currentChordSelected == index
                                          ? Color.fromRGBO(255, 209, 128, 1)
                                          : Color.fromRGBO(255, 209, 128, 0.5),
                                      height: (screenHeight / 8) - 1,
                                      child: Center(
                                          child: RichText(
                                        text: TextSpan(
                                            text: Settings.instance
                                                .chordList[index].trebleNote,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    10, 100, 200, 0.8),
                                                fontSize: 25)),
                                      )),
                                    ),
                                    Container(
                                      color: currentChordSelected == index
                                          ? Color.fromRGBO(179, 136, 255, 1)
                                          : Color.fromRGBO(179, 136, 255, 0.5),
                                      height: (screenHeight / 8) - 1,
                                      child: Center(
                                          child: RichText(
                                        text: TextSpan(
                                            text: Settings.instance
                                                .chordList[index].bassNote,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    10, 100, 200, 0.8),
                                                fontSize: 25)),
                                      )),
                                    )
                                  ],
                                )),
                          );
                        }),
                    InkWell(
                      onTap: () => _addChord(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 100, 200, 0.5),
                            border: Border.all(
                                color: Color.fromRGBO(0, 100, 200, 0.8),
                                width: 1)),
                        height: screenHeight / 4,
                        width: screenHeight / 4,
                        child: Center(
                            child: RichText(
                          text: TextSpan(
                              text: '+',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(10, 100, 200, 0.8),
                                  fontSize: 25)),
                        )),
                      ),
                    )
                  ]),
            ),
            // Setting Panel
            Container(
                color: backgroundColor,
                height: 3 * screenHeight / 4,
                child: Row(
                  children: [
                    // Chords Settings
                    Container(
                        decoration: BoxDecoration(
                            color: backgroundColor, border: mainBorder),
                        width: 2 * (screenWidth / 11),
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() =>
                                    Settings.instance.currentSettingsAction =
                                        actions.treble.index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Settings.instance
                                                .currentSettingsAction ==
                                            actions.treble.index
                                        ? Border.all(
                                            color: Colors.orangeAccent,
                                            width: 1)
                                        : null,
                                    borderRadius: BorderRadius.circular(12)),
                                height: 50,
                                child: Center(
                                    child: RichText(
                                  text: TextSpan(
                                      text: 'Treble',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orangeAccent,
                                          fontSize: 25)),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() =>
                                    Settings.instance.currentSettingsAction =
                                        actions.bass.index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Settings.instance
                                                .currentSettingsAction ==
                                            actions.bass.index
                                        ? Border.all(
                                            color: Colors.deepPurpleAccent,
                                            width: 1)
                                        : null,
                                    borderRadius: BorderRadius.circular(12)),
                                height: 50,
                                child: Center(
                                    child: RichText(
                                  text: TextSpan(
                                      text: 'Bass',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 25)),
                                )),
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     setState(() =>
                            //         Settings.instance.currentSettingsAction =
                            //             actions.beats.index);
                            //   },
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //         border: Settings.instance
                            //                     .currentSettingsAction ==
                            //                 actions.beats.index
                            //             ? Border.all(
                            //                 color: Settings.instance
                            //                             .currentBeats ==
                            //                         ""
                            //                     ? Colors.blueGrey
                            //                     : Colors.lightBlueAccent,
                            //                 width: 1)
                            //             : null,
                            //         borderRadius: BorderRadius.circular(12)),
                            //     height: 50,
                            //     child: Center(
                            //         child: RichText(
                            //       text: TextSpan(
                            //           text: 'Beats',
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               color:
                            //                   Settings.instance.currentBeats ==
                            //                           ""
                            //                       ? Colors.blueGrey
                            //                       : Colors.lightBlueAccent,
                            //               fontSize: 25)),
                            //     )),
                            //   ),
                            // ),
                            SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() =>
                                    Settings.instance.currentSettingsAction =
                                        actions.tempo.index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Settings.instance
                                                .currentSettingsAction ==
                                            actions.tempo.index
                                        ? Color.fromRGBO(255, 255, 255, 0.6)
                                        : null,
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                                height: 30,
                                child: Center(
                                    child: RichText(
                                  text: TextSpan(
                                      text: Settings.instance.currentTempo
                                              .toString() +
                                          'BPM',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                )),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            IconButton(
                              icon: Icon(Icons.play_circle_outline),
                              color: Settings.instance.currentPlayState == 0
                                  ? Colors.green
                                  : Colors.greenAccent,
                              iconSize: 50.0,
                              onPressed: () {
                                Settings.instance.playAll(context);
                              },
                            ),
                            IconButton(
                              icon: Settings.instance.currentPlayState == 2
                                  ? Icon(Icons.stop_circle_outlined)
                                  : Icon(Icons.pause_circle_outline),
                              color: Settings.instance.currentPlayState == 0
                                  ? Colors.blueGrey
                                  : (Settings.instance.currentPlayState == 1
                                      ? Colors.lime
                                      : Colors.red),
                              iconSize: 50.0,
                              onPressed: () {
                                switch (Settings.instance.currentPlayState) {
                                  case 1:
                                    Settings.instance.playPause(context);
                                    break;
                                  case 2: //stop
                                    Settings.instance.playStop(context);
                                    break;
                                  default:
                                    break;
                                }
                              },
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              iconSize: 40.0,
                              onPressed: () =>
                                  Settings.instance.removeChord(context),
                            ),
                          ],
                        )),
                    // Page Content
                    ContentView(
                        appConstant, Settings.instance.currentSettingsAction),
                  ],
                )),
          ],
        ));
      } else {
        BlocProvider.of<SettingsBloc>(context).add(SettingsChangeEvent());
        return Container();
      }
    });
  }
}
