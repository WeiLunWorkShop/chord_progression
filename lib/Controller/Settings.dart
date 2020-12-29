import 'package:chord_progression/Controller/AudioManagement.dart';
import 'package:chord_progression/Model/ChordObject.dart';

import 'ChordPattern.dart';

class Settings {
  Settings._privateConstructor();
  static final Settings instance = Settings._privateConstructor();

  ChordObject currentChord;
  int currentChordIndex;
  int currentSettingsAction;

  void buttonSelect(AudioManagement audio, String note) {
    audio.play(ChordPattern.getChord(note));
    switch (instance.currentSettingsAction) {
      case 0: //treble
        instance.currentChord.trebleNote = note;
        break;
      case 1: //bass
        instance.currentChord.bassNote = note;
        break;
      default:
        break;
    }
  }

  void actionSelect(int action) {
    instance.currentSettingsAction = action;
    print(action);
  }
}
