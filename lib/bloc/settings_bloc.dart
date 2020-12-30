import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chord_progression/Controller/AudioManagement.dart';
import 'package:chord_progression/Controller/ChordPattern.dart';
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
    } else if (event is SettingsChordButtonSelectEvent) {
      //AudioManagement.instance.play(ChordPattern.getChord(event.text));
      yield SettingsOnEvent();
    }
  }
}
