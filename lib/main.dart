import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Future<void> _incrementCounter() async {
    AudioCache audioCache = AudioCache();
    //AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    AudioPlayer.logEnabled = true;

    await audioCache.play("audio/A0.mp3", mode: PlayerMode.LOW_LATENCY);
    await audioCache.play("audio/D1.mp3", mode: PlayerMode.LOW_LATENCY);
    await audioCache.play("audio/F1.mp3", mode: PlayerMode.LOW_LATENCY);
    await audioCache.play("audio/G1.mp3", mode: PlayerMode.LOW_LATENCY);
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
    // borderRadius: BorderRadius.circular(12)

    return Scaffold(
        body: Column(
      children: [
        // Chords Panel
        Container(
          color: mainColor,
          height: screenHeight / 4,
        ),
        Container(
            color: backgroundColor,
            height: 3 * screenHeight / 4,
            child: Row(
              children: [
                // Chords Settings
                Container(
                    decoration: BoxDecoration(
                        color: backgroundColor, border: mainBorder),
                    width: screenWidth / 6,
                    child: Column(
                      children: [
                        // Title
                        createTitle("Settings", mainBorder, screenWidth)
                      ],
                    )),
                keyContent(screenWidth, screenHeight, panelLineWidth,
                    borderColor, backgroundColor, mainColor, mainBorder),
              ],
            )),
      ],
    ));
  }
}

Container createTitle(String title, Border mainBorder, double screenWidth) {
  return Container(
    decoration: BoxDecoration(color: Colors.blueGrey, border: mainBorder),
    width: screenWidth / 6,
    height: 40.0,
    child: Center(
        child: RichText(
      text: TextSpan(
          text: title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      //textAlign: TextAlign.center,
    )),
  );
}

Row keyContent(
    double screenWidth,
    double screenHeight,
    double panelLineWidth,
    Color borderColor,
    Color backgroundColor,
    Color mainColor,
    Border mainBorder) {
  return Row(
    children: [
      // Notes
      Container(
          decoration: BoxDecoration(color: backgroundColor, border: mainBorder),
          width: screenWidth / 6,
          child: Column(
            children: [
              // Title
              createTitle("Notes", mainBorder, screenWidth)
            ],
          )),
      // Keys
      Container(
          decoration: BoxDecoration(color: backgroundColor, border: mainBorder),
          width: screenWidth / 6,
          child: Column(
            children: [
              // Title
              createTitle("Keys", mainBorder, screenWidth)
            ],
          )),
      // Tensions
      Container(
          decoration: BoxDecoration(color: backgroundColor, border: mainBorder),
          width: screenWidth / 6,
          child: Column(
            children: [
              // Title
              createTitle("Tensions", mainBorder, screenWidth)
            ],
          )),
      // Inversions
      Container(
          decoration: BoxDecoration(color: backgroundColor, border: mainBorder),
          width: screenWidth / 6,
          child: Column(
            children: [
              // Title
              createTitle("Inversions", mainBorder, screenWidth)
            ],
          )),
      // Arpeggios
      Container(
          decoration: BoxDecoration(
              border: Border.all(width: panelLineWidth, color: borderColor)),
          width: screenWidth / 6,
          child: Column(
            children: [
              // Title
              createTitle("Arpeggios", mainBorder, screenWidth)
            ],
          )),
    ],
  );
}
