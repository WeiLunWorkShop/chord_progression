import 'package:chord_progression/Controller/AudioManagement.dart';
import 'package:chord_progression/View/HomeView.dart';
import 'package:chord_progression/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    AudioManagement.instance.audioCache.loadAll(AudioManagement.instance.notes);
    AudioManagement.instance.beatCache
        .loadAll(AudioManagement.instance.drumLoops);
    return MaterialApp(
      title: 'Chord Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
          create: (context) => SettingsBloc(), child: MyHomePage()),
    );
  }
}
