import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chord_progression/Controller/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Model/ChordObject.dart';
import 'View/Settings/KeyContent.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chord Pro',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ChordObject> chordList = new List<ChordObject>();
  Settings settings = new Settings();

  Future<void> _addChord() async {
    setState(() {
      chordList.add(new ChordObject("", "", "", "", "", "", "", "", "", ""));
      settings.setCurrentChordIndex = chordList.length - 1;
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
    Color mainColor = Color.fromRGBO(58, 221, 243, 0.5);

    Border mainBorder = Border(
        top: BorderSide(width: panelLineWidth, color: borderColor),
        left: BorderSide(width: panelLineWidth, color: borderColor),
        bottom: BorderSide(width: panelLineWidth, color: borderColor));

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
                    itemCount: chordList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => setState(
                            () => settings.setCurrentChordIndex = index),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(179, 136, 255, 0.8),
                                    width: 1)),
                            height: screenHeight / 4,
                            width: screenHeight / 4,
                            child: Column(
                              children: [
                                Container(
                                  color: settings.getCurrentChordIndex == index
                                      ? Color.fromRGBO(255, 209, 128, 1)
                                      : Color.fromRGBO(255, 209, 128, 0.5),
                                  height: (screenHeight / 8) - 1,
                                ),
                                Container(
                                  color: settings.getCurrentChordIndex == index
                                      ? Color.fromRGBO(179, 136, 255, 1)
                                      : Color.fromRGBO(179, 136, 255, 0.5),
                                  height: (screenHeight / 8) - 1,
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
                            color: Color.fromRGBO(0, 100, 200, 0.8), width: 1)),
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
                    child: listViewSettings()),
                keyContent(screenWidth, screenHeight, panelLineWidth,
                    borderColor, backgroundColor, mainColor, mainBorder),
              ],
            )),
      ],
    ));
  }
}

Widget listViewSettings() {
  return ListView(
    padding: const EdgeInsets.all(8),
    shrinkWrap: true,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.orangeAccent, width: 1),
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
      Container(
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
      Container(
        height: 50,
        child: Center(
            child: RichText(
          text: TextSpan(
              text: 'Beats',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent,
                  fontSize: 25)),
        )),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.white)),
        height: 30,
        child: Center(
            child: RichText(
          text: TextSpan(
              text: '120BPM',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        )),
      ),
      SizedBox(
        height: 10.0,
      ),
      const Divider(
        color: Colors.grey,
        //height: 20,
        thickness: 1,
      ),
      IconButton(
        icon: Icon(Icons.play_circle_outline),
        color: Colors.greenAccent,
        iconSize: 50.0,
        //tooltip: 'Increase volume by 10',
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.pause_circle_outline),
        color: Colors.limeAccent,
        iconSize: 50.0,
        //tooltip: 'Increase volume by 10',
        onPressed: () {},
      ),
      const Divider(
        color: Colors.grey,
        //height: 20,
        thickness: 1,
      ),
      IconButton(
        icon: Icon(Icons.delete),
        color: Colors.red,
        iconSize: 40.0,
        //tooltip: 'Increase volume by 10',
        onPressed: () {},
      ),
    ],
  );
}
