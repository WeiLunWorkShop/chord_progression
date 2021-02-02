import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chord_progression/Controller/AudioManagement.dart';
import 'package:chord_progression/Controller/ChordPattern.dart';
import 'package:chord_progression/Controller/Settings.dart';
import 'package:chord_progression/Model/ChordObject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is SettingsChangeEvent) {
      yield SettingsOnEvent();
    } else if (event is SettingsChordSelectEvent) {
      // AudioManagement.instance.playWithGrooves(
      //     ChordPattern.getWholeChord(),
      //     Settings.instance.chordList[Settings.instance.currentChordIndex]
      //         .trebleGrooves,
      //     Settings.instance.currentTempo);
      //AudioManagement.instance.play();

      // AudioManagement.instance.playWithGrooves(
      //     ChordPattern.getSingleChord(true),
      //     Settings.instance.chordList[Settings.instance.currentChordIndex]
      //         .trebleGrooves,
      //     Settings.instance.currentTempo);
      // AudioManagement.instance.playWithGrooves(
      //     ChordPattern.getSingleChord(false),
      //     Settings.instance.chordList[Settings.instance.currentChordIndex]
      //         .bassGrooves,
      //     Settings.instance.currentTempo);
      print('start play');
      AudioManagement.instance.playAllWithGrooves(ChordPattern.getPlaySequence(
          ChordPattern.getSingleChord(true),
          ChordPattern.getSingleChord(false)));
      yield SettingsOnEvent();
    } else if (event is SettingsChordButtonSelectEvent) {
      // AudioManagement.instance.play(ChordPattern.getSingleChord(
      //     Settings.instance.currentSettingsAction == 0));
      bool isTreble = Settings.instance.currentSettingsAction == 0;
      ChordObject currentChord =
          Settings.instance.chordList[Settings.instance.currentChordIndex];
      AudioManagement.instance.playWithGrooves(
          ChordPattern.getSingleChord(isTreble),
          isTreble ? currentChord.trebleGrooves : currentChord.bassGrooves,
          Settings.instance.currentTempo);
      yield SettingsOnEvent();
    }
  }
}
