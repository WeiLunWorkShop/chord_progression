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

  static var baseMap = {
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
  };

  static var trebleMap = {
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
    24: 'C6'
  };

  // var test =
  //     noteMap.keys.firstWhere((k) => noteMap[k] == 'C', orElse: () => null);

  static List<String> getChord(String noteString) {
    int baseNote = noteMap.keys
        .firstWhere((k) => noteMap[k] == noteString, orElse: () => null);

    List<String> chordList = [
      trebleMap[baseNote],
      trebleMap[baseNote + 4],
      trebleMap[baseNote + 7]
    ];

    return chordList;
  }
}
