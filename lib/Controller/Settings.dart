import 'package:chord_progression/Controller/AudioManagement.dart';
import 'package:chord_progression/Model/ChordObject.dart';

import 'ChordPattern.dart';

class Settings {
  Settings._privateConstructor();
  static final Settings instance = Settings._privateConstructor();

  List<ChordObject> chordList = new List<ChordObject>.generate(
      1, (index) => new ChordObject("", "", "", "", "", "", "", "", "", ""));
  int currentChordIndex = 0;
  int currentSettingsAction = 0;

  void chordSelect(int chordIndex) {
    instance.currentChordIndex = chordIndex;
    print(chordIndex);
  }

  void buttonSelect(AudioManagement audio, String text) {
    audio.play(ChordPattern.getChord(text));
    switch (instance.currentSettingsAction) {
      case 0: //treble
        print(text);
        instance.chordList[currentChordIndex].trebleNote = text;
        break;
      case 1: //bass
        print(text);
        instance.chordList[currentChordIndex].bassNote = text;
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
