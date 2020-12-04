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
  int _counter = 0;

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(
      children: [
        // Chords Panel
        Container(
          color: Colors.greenAccent,
          height: screenHeight / 4,
        ),
        // Chords Settings
        Container(
          color: Colors.blueAccent,
          height: 3 * screenHeight / 4,
          child: Row(
            children: [
              // Settings
              Container(
                  color: Colors.black,
                  width: screenWidth / 6,
                  child: Column(
                    children: [
                      // Title
                      PreferredSize(
                          preferredSize: Size.fromRadius(screenWidth / 6),
                          child: Container(
                            width: screenHeight / 6,
                            color: Colors.blueGrey,
                            child: RichText(
                              text: TextSpan(
                                  text: 'Settings',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                          )),
                    ],
                  )),
              // Notes
              Container(
                color: Colors.white,
                width: screenWidth / 6,
              ),
              // Keys
              Container(
                color: Colors.red,
                width: screenWidth / 6,
              ),
              // Tensions
              Container(
                color: Colors.blue,
                width: screenWidth / 6,
              ),
              // Inversions
              Container(
                color: Colors.yellow,
                width: screenWidth / 6,
              ),
              // Arpeggios
              Container(
                color: Colors.orange,
                width: screenWidth / 6,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
