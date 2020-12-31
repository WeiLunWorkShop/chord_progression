import 'package:chord_progression/Controller/AudioManagement.dart';
import 'package:chord_progression/Model/ChordObject.dart';
import 'package:chord_progression/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings {
  Settings._privateConstructor();
  static final Settings instance = Settings._privateConstructor();

  List<ChordObject> chordList =
      new List<ChordObject>.generate(1, (index) => new ChordObject());
  int currentChordIndex = 0;
  int currentSettingsAction = 0;
  String currentBeats = "";
  int currentTempo = 120;
  int currentPlayState = 0; // 0: not playing; 1: playing; 2: pause
  int pausePoint = 0;

  void chordSelect(BuildContext context, int index) {
    Settings.instance.currentChordIndex = index;
    BlocProvider.of<SettingsBloc>(context).add(SettingsChordSelectEvent());
  }

  Future<void> playAll(BuildContext context) async {
    int currentChordIndex = Settings.instance.currentChordIndex;
    Settings.instance.currentPlayState = 1;

    for (int i = 0; i < Settings.instance.chordList.length; i++) {
      chordSelect(context, i);
      await Future.delayed(Duration(milliseconds: getTempo()));
      AudioManagement.instance.audioPlayer.stop();
    }
    this.pausePoint = 0;
    this.currentPlayState = 0;
    this.currentChordIndex = currentChordIndex;
    BlocProvider.of<SettingsBloc>(context).add(SettingsChangeEvent());
  }

  void playPause(BuildContext context) {
    AudioManagement.instance.audioPlayer.pause();
    print('pause');

    AudioManagement.instance.audioPlayer.onAudioPositionChanged
        .listen((duration) => this.pausePoint = duration.inSeconds);

    print(pausePoint);

    Settings.instance.currentPlayState = 2;
    BlocProvider.of<SettingsBloc>(context).add(SettingsChangeEvent());
  }

  int getTempo() {
    return ((60 / Settings.instance.currentTempo) * 1000).round();
  }

  void removeChord(BuildContext context) {
    // remove chord
    this.chordList.removeAt(this.currentChordIndex);

    // reset current chord
    if (this.currentChordIndex == this.chordList.length) if (this
        .chordList
        .isEmpty) {
      this.chordList.add(new ChordObject());
      this.currentChordIndex = 0;
    } else
      this.currentChordIndex--;

    BlocProvider.of<SettingsBloc>(context).add(SettingsChangeEvent());
  }
}
