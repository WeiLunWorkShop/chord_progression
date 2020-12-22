import 'package:chord_progression/Controller/AudioManagement.dart';
import 'package:chord_progression/Model/ChordObject.dart';

import 'ChordPattern.dart';

class Settings {
  // ignore: non_constant_identifier_names
  static void ButtonSelect(String note) {
    AudioManagement.play(ChordPattern.getChord(note));
  }

  ChordObject currentChord;
  get getCurrentChord => currentChord;
  set setCurrentChord(ChordObject obj) => this.currentChord = obj;

  int currentChordIndex;
  int get getCurrentChordIndex => currentChordIndex;
  set setCurrentChordIndex(int currentChordIndex) =>
      this.currentChordIndex = currentChordIndex;
}
