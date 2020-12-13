import 'package:chord_progression/Controller/AudioManagement.dart';

import 'ChordPattern.dart';

class Settings {
  // ignore: non_constant_identifier_names
  static void ButtonSelect(String note) {
    ChordPattern.getChord(note);
    // AudioManagement.play();
  }
}
