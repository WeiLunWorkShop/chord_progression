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
  // Future<void> _incrementCounter() async {
  //   AudioCache audioCache = AudioCache();
  //   //AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  //   AudioPlayer.logEnabled = true;

  //   await audioCache.play("audio/A0.mp3", mode: PlayerMode.LOW_LATENCY);
  //   await audioCache.play("audio/D1.mp3", mode: PlayerMode.LOW_LATENCY);
  //   await audioCache.play("audio/F1.mp3", mode: PlayerMode.LOW_LATENCY);
  //   await audioCache.play("audio/G1.mp3", mode: PlayerMode.LOW_LATENCY);
  // }

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
          color: Colors.white,
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

// Container createTitle(String title, Border mainBorder, double screenWidth) {
//   return Container(
//     decoration: BoxDecoration(color: Colors.transparent, border: mainBorder),
//     width: screenWidth / 10,
//     height: 40.0,
//     child: Center(
//         child: RichText(
//       text: TextSpan(
//           text: title,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//       //textAlign: TextAlign.center,
//     )),
//   );
// }

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

Widget listViewSettings() {
  return ListView(
    padding: const EdgeInsets.all(8),
    shrinkWrap: true,
    children: <Widget>[
      Container(
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
          widgetList.add(Container(
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
              ))));
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

// Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: <Color>[
//                 Color(0xFF0D47A1),
//                 Color(0xFF1976D2),
//                 Color(0xFF42A5F5),
//               ],
//             ),
//           ),
