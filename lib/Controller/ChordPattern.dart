class ChordPattern {
  static var noteMap = {
    'C': 0,
    'C♯/D♭': 1,
    'D': 2,
    'D♯/E♭': 3,
    'E': 4,
    'F': 5,
    'F♯/G♭': 6,
    'G': 7,
    'G♯/A♭': 8,
    'A': 9,
    'A♯/B♭': 10,
    'B': 11
  };

<<<<<<< Updated upstream
  var test =
      noteMap.keys.firstWhere((k) => noteMap[k] == 0, orElse: () => null);

=======
>>>>>>> Stashed changes
  static void getChord(String noteString) {
    int note = noteMap[noteString];

    print(note);
  }
}
