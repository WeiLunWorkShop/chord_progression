import 'package:chord_progression/Controller/Settings.dart';
import 'package:chord_progression/Model/ChordObject.dart';

class ChordPattern {
  static var noteMap = {
    0: 'C',
    1: 'C♯/D♭',
    2: 'D',
    3: 'D♯/E♭',
    4: 'E',
    5: 'F',
    6: 'F♯/G♭',
    7: 'G',
    8: 'G♯/A♭',
    9: 'A',
    10: 'A♯/B♭',
    11: 'B'
  };

  static var tensionMap = {
    '♭7': 10,
    '7': 11,
    '♭9': 13,
    '9': 14,
    '♯9': 15,
    '11': 17,
    '♯11': 18,
    '♭13': 20,
    '13': 21,
    'L♭7': -2,
    'L7': -1,
    '♭2': 1,
    '2': 2,
    '♯2': 3,
    'sus4': 5,
    '♯4': 6,
    '♭6': 8,
    '6': 9
  };

  static var bassMap = {
    -2: 'Bb1',
    -1: 'B1',
    0: 'C2',
    1: 'Db2',
    2: 'D2',
    3: 'Eb2',
    4: 'E2',
    5: 'F2',
    6: 'F#2',
    7: 'G2',
    8: 'Ab2',
    9: 'A2',
    10: 'Bb2',
    11: 'B2',
    12: 'C3',
    13: 'Db3',
    14: 'D3',
    15: 'Eb3',
    16: 'E3',
    17: 'F3',
    18: 'F#3',
    19: 'G3',
    20: 'Ab3',
    21: 'A3',
    22: 'Bb3',
    23: 'B3',
    24: 'C4',
    25: 'Db4',
    26: 'D4',
    27: 'Eb4',
    28: 'E4',
    29: 'F4',
    30: 'F#4',
    31: 'G4',
  };

  static var trebleMap = {
    -2: 'Bb3',
    -1: 'B3',
    0: 'C4',
    1: 'Db4',
    2: 'D4',
    3: 'Eb4',
    4: 'E4',
    5: 'F4',
    6: 'F#4',
    7: 'G4',
    8: 'Ab4',
    9: 'A4',
    10: 'Bb4',
    11: 'B4',
    12: 'C5',
    13: 'Db5',
    14: 'D5',
    15: 'Eb5',
    16: 'E5',
    17: 'F5',
    18: 'F#5',
    19: 'G5',
    20: 'Ab5',
    21: 'A5',
    22: 'Bb5',
    23: 'B5',
    24: 'C6',
    25: 'Db6',
    26: 'D6',
    27: 'Eb6',
    28: 'E6',
    29: 'F6',
    30: 'F#6',
    31: 'G6'
  };

  static List<String> getSingleChord(bool isTreble) {
    ChordObject currentChord =
        Settings.instance.chordList[Settings.instance.currentChordIndex];
    List<int> intChordList = new List<int>();
    List<String> chordList = List<String>();
    int baseNote = noteMap.keys.firstWhere(
        (note) =>
            noteMap[note] ==
            (isTreble ? currentChord.trebleNote : currentChord.bassNote),
        orElse: () => -1);

    // return when not treble or bass or note not selected
    if (isTreble == null || baseNote == -1) return chordList;

    // generate int chord list
    // Key
    switch (isTreble ? currentChord.trebleKey : currentChord.bassKey) {
      case "△":
        intChordList.addAll([0, 4, 7]);
        break;
      case "-":
        intChordList.addAll([0, 3, 7]);
        break;
      case "O":
        intChordList.addAll([0, 3, 6]);
        break;
      case "+":
        intChordList.addAll([0, 4, 8]);
        break;
      default:
        intChordList.addAll([0, 4, 7]);
        break;
    }

    // Inversion
    int octave = 12;
    switch (
        isTreble ? currentChord.trebleInversion : currentChord.bassInversion) {
      case '1':
        intChordList.add(12);
        intChordList.removeAt(0);
        break;
      case '2':
        intChordList
            .addAll([intChordList[0] + octave, intChordList[1] + octave]);
        intChordList.removeRange(0, 1);
        break;
      case '3':
        intChordList.addAll([
          intChordList[0] + octave,
          intChordList[1] + octave,
          intChordList[2] + octave
        ]);
        intChordList.removeRange(0, 2);
        break;
      case 'R': // (default, no change)
      default:
        break;
    }

    // Tension
    var tensionList =
        isTreble ? currentChord.trebleTension : currentChord.bassTension;

    tensionList.forEach((element) => intChordList.add(tensionMap[element]));

    // generate chord list
    Map<int, String> currentMap = isTreble ? trebleMap : bassMap;

    // loop int list
    intChordList.forEach((note) => chordList.add(currentMap[baseNote + note]));

    return chordList;
  }

  static List<String> getWholeChord() {
    List<String> chordList = new List<String>();

    // get treble chord
    chordList.addAll(getSingleChord(true));

    // get bass chord
    chordList.addAll(getSingleChord(false));

    return chordList;
  }
}
