import 'package:audioplayers/audioplayers.dart';
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
  int tempChordIndex = 0;
  int currentSettingsAction = 0;
  String currentBeats = "";
  int currentTempo = 120;
  int currentPlayState = 0; // 0: default(rest); 1: playing; 2: pause
  Stopwatch pausePoint = new Stopwatch();

  void chordSelect(BuildContext context, int index) {
    AudioPlayer.players.forEach((playerId, audioPlayer) => audioPlayer.stop());
    Settings.instance.currentChordIndex = index;
    BlocProvider.of<SettingsBloc>(context).add(SettingsChordSelectEvent());
  }

  Future<void> playAll(BuildContext context) async {
    int currentChordIndex = Settings.instance.currentChordIndex;
    Settings.instance.currentPlayState = 1;

    // get start point, check paused
    int startPoint = pausePoint.elapsedMilliseconds == 0
        ? 0
        : pausePoint.elapsedMilliseconds ~/ getTempo();

    // start timer / continue
    this.pausePoint.start();

    for (int i = startPoint; i < Settings.instance.chordList.length; i++) {
      chordSelect(context, i);

      await Future.delayed(Duration(milliseconds: getTempo()));

      // paused
      if (this.currentPlayState == 2) {
        this.tempChordIndex = i;
        break;
      } else if (i == Settings.instance.chordList.length - 1) {
        this.pausePoint.stop();
        this.pausePoint.reset();
      }
    }

    this.currentPlayState = this.currentPlayState == 2 ? 2 : 0;
    this.currentChordIndex = currentChordIndex;
    BlocProvider.of<SettingsBloc>(context).add(SettingsChangeEvent());
  }

  int getTempo() {
    return ((60 / Settings.instance.currentTempo) * 1000).round();
  }

  void playPause(BuildContext context) {
    this.pausePoint.stop();
    this.currentPlayState = 2;

    AudioPlayer.players.forEach((playerId, audioPlayer) => audioPlayer.stop());

    BlocProvider.of<SettingsBloc>(context).add(SettingsChangeEvent());
  }

  void playStop(BuildContext context) {
    this.currentPlayState = 0;
    this.tempChordIndex = 0;

    // reset timer
    this.pausePoint.stop();
    this.pausePoint.reset();

    BlocProvider.of<SettingsBloc>(context).add(SettingsChangeEvent());
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
