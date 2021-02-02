import 'package:chord_progression/Controller/Settings.dart';
import 'package:chord_progression/Model/ChordObject.dart';
import 'package:chord_progression/Model/GrooveObject.dart';
import 'package:chord_progression/Model/PlayingSequenceObject.dart';

class ChordPattern {
  static var noteMap = {
    0: 'C',
    1: 'C♯D♭',
    2: 'D',
    3: 'D♯E♭',
    4: 'E',
    5: 'F',
    6: 'F♯G♭',
    7: 'G',
    8: 'G♯A♭',
    9: 'A',
    10: 'A♯B♭',
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
    '♭2': 1,
    '2': 2,
    '♯2': 3,
    '4': 5,
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

  static Map<String, List<int>> trebleKeyInversion = {
    'RMaj': [0, 4, 7],
    'RMin': [0, 3, 7],
    'RDim': [0, 3, 6],
    'RAug': [0, 4, 8],
    'R5th': [0, 7],
    'R8ve': [0, 12],
    '1Maj': [4, 7, 12],
    '1Min': [3, 7, 12],
    '1Dim': [3, 6, 12],
    '1Aug': [4, 8, 12],
    '15th': [7, 12],
    '18ve': [-12, 0],
    '2Maj': [-5, 0, 4],
    '2Min': [-5, 0, 3],
    '2Dim': [-6, 0, 3],
    '2Aug': [-4, 0, 4],
    '25th': [-5, 0],
    '28ve': [],
  };

  static Map<String, List<int>> bassKeyInversion = {
    'RMaj': [0, 7, 16],
    'RMin': [0, 7, 15],
    'RDim': [0, 6, 15],
    'RAug': [0, 8, 16],
    'R5th': [0, 7],
    'R8ve': [0, 12],
    '1Maj': [4, 12, 19],
    '1Min': [3, 12, 19],
    '1Dim': [3, 12, 18],
    '1Aug': [4, 12, 20],
    '15th': [7, 12],
    '18ve': [0, 12],
    '<2Maj': [7, 16, 24],
    '<2Min': [7, 15, 24],
    '<2Dim': [6, 15, 24],
    '<2Aug': [8, 16, 24],
    '<25th': [12, 19],
    '<28ve': [0, 12],
    '>2Maj': [-5, 4, 12],
    '>2Min': [-5, 3, 12],
    '>2Dim': [-6, 3, 12],
    '>2Aug': [-4, 4, 12],
    '>25th': [12, 19],
    '>28ve': [0, 12],
  };

  static List<String> getSingleChord(bool isTreble) {
    ChordObject currentChord =
        Settings.instance.chordList[Settings.instance.currentChordIndex];
    String keyInversion = isTreble
        ? currentChord.trebleInversion + currentChord.trebleKey
        : (currentChord.bassInversion == '2'
                ? ([
                    'C2',
                    'Db2',
                    'D2',
                    'Eb2',
                    'E2',
                    'F2',
                  ].contains(currentChord.bassNote))
                    ? '<'
                    : '>'
                : '') +
            currentChord.bassInversion +
            currentChord.bassKey;

    List<int> intChordList = isTreble
        ? trebleKeyInversion[keyInversion]
        : bassKeyInversion[keyInversion];

    List<String> chordList = List<String>();
    int baseNote = noteMap.keys.firstWhere(
        (note) =>
            noteMap[note] ==
            (isTreble ? currentChord.trebleNote : currentChord.bassNote),
        orElse: () => -1);

    // return when not treble or bass or note not selected
    if (isTreble == null || baseNote == -1) return chordList;

    // // generate int chord list
    //   // Key
    //   switch (currentChord.trebleKey) {
    //     case "Maj":
    //       intChordList.addAll([0, 4, 7]);
    //       break;
    //     case "Min":
    //       intChordList.addAll([0, 3, 7]);
    //       break;
    //     case "Dim":
    //       intChordList.addAll([0, 3, 6]);
    //       break;
    //     case "Aug":
    //       intChordList.addAll([0, 4, 8]);
    //       break;
    //     case "5th":
    //       intChordList.addAll([0, 7]);
    //       break;
    //     case "8ve":
    //       intChordList.addAll([0, 12]);
    //       break;
    //     default:
    //       intChordList.addAll([0, 4, 7]);
    //       break;
    //   }

    // // Inversion
    // int octave = 12;
    // switch (
    //     isTreble ? currentChord.trebleInversion : currentChord.bassInversion) {
    //   case '1':
    //       if (isTreble) {
    //         if (currentChord.trebleKey == "8ve"){
    //           intChordList.add(-12);
    //           intChordList.removeAt(1);
    //         }
    //         else {
    //           intChordList.add(12);
    //           intChordList.removeAt(0);
    //         }
    //       }
    //       else {
    //         // if (currentChord.bassKey == "")
    //       }
    //     break;
    //   case '2':
    //     intChordList
    //         .addAll([intChordList[0] + octave, intChordList[1] + octave]);
    //     intChordList.removeRange(0, 1);
    //     break;
    //   case '3':
    //     intChordList.addAll([
    //       intChordList[0] + octave,
    //       intChordList[1] + octave,
    //       intChordList[2] + octave
    //     ]);
    //     intChordList.removeRange(0, 2);
    //     break;
    //   case 'R': // (default, no change)
    //   default:
    //     break;
    // }

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

  static PlayingSequenceObject getPlaySequence(
      List<String> trebleChord, List<String> bassChord) {
    ChordObject currentChord =
        Settings.instance.chordList[Settings.instance.currentChordIndex];
    List<String> txChord = new List<String>();
    List<String> tyChord = new List<String>();
    List<String> bxChord = new List<String>();
    List<String> byChord = new List<String>();

    // check is separate chord
    bool trebleIsSeparate = false;
    bool bassIsSeparate = false;

    print('generating chord');

    // set up both chord
    //treble
    if (["𝅗𝅥", "𝅘𝅥", "𝅗𝅥."].contains(currentChord.trebleGrooves)) {
      trebleIsSeparate = true;
      for (int note = 0; note < trebleChord.length; note++) {
        if (note.isOdd)
          txChord.add(trebleChord[note]);
        else
          tyChord.add(trebleChord[note]);
      }
    }
    // bass
    if (["𝅗𝅥", "𝅘𝅥", "𝅗𝅥."].contains(currentChord.bassGrooves)) {
      bassIsSeparate = true;
      for (int note = 0; note < bassChord.length; note++) {
        if (note.isOdd)
          bxChord.add(bassChord[note]);
        else
          byChord.add(bassChord[note]);
      }
    }

    // get both grooves
    GrooveObject trebleGrooveItem =
        new GrooveObject().getGrooveObject(currentChord.trebleGrooves);
    GrooveObject bassGrooveItem =
        new GrooveObject().getGrooveObject(currentChord.bassGrooves);
    List<double> trebleGroove = trebleGrooveItem.playItems;
    List<double> bassGroove = bassGrooveItem.playItems;

    // add on groove by loop times
    if (trebleGrooveItem.playLoopTimes > 1) {
      List<double> tempList = new List<double>();
      for (int i = 1; i < trebleGrooveItem.playLoopTimes; i++) {
        tempList.addAll(trebleGrooveItem.playItems);
      }
      trebleGroove.addAll(tempList);
    }
    if (bassGrooveItem.playLoopTimes > 1) {
      List<double> tempList = new List<double>();
      for (int i = 1; i < bassGrooveItem.playLoopTimes; i++) {
        tempList.addAll(bassGrooveItem.playItems);
      }
      bassGroove.addAll(tempList);
    }

    List<List<String>> resultChord = new List<List<String>>();
    List<double> resultGroove = new List<double>();
    // start with 0
    int treblePoint = 0;
    int bassPoint = 0;
    double trebleTiming = 0;
    double bassTiming = 0;
    double mainTiming = 0;
    bool tIsX = true;
    bool bIsX = true;

    // while the mainTiming is not full
    while (mainTiming < 4.0) {
      print('mainTiming: ' + mainTiming.toString());
      // bass longer than trable
      if (trebleTiming < bassTiming) {
        print('treble');
        mainTiming += trebleGroove[treblePoint];

        // set result
        resultGroove.add(trebleGroove[treblePoint]);
        resultChord
            .add(trebleIsSeparate ? (tIsX ? txChord : tyChord) : trebleChord);

        // set chord item
        tIsX = !tIsX;

        // set treble total timing
        trebleTiming += trebleGroove[treblePoint];

        // if not last item
        if (treblePoint < trebleGroove.length - 1) {
          // set treble point
          treblePoint++;
        }
      }
      // treble longer than bass
      else if (trebleTiming > bassTiming) {
        print('bass');
        mainTiming += bassGroove[bassPoint];

        // set result
        resultGroove.add(bassGroove[bassPoint]);
        resultChord
            .add(bassIsSeparate ? (bIsX ? bxChord : byChord) : bassChord);

        // set chord item
        bIsX = !bIsX;

        // set bass total timing
        bassTiming += bassGroove[bassPoint];

        // if not last item
        if (bassPoint < bassGroove.length - 1) {
          // set basspoint
          bassPoint++;
        }
      }
      // treble equal to bass
      else {
        print('same');
        // adding combined chord
        List<String> tempChord = new List<String>();
        tempChord
            .addAll(bassIsSeparate ? (bIsX ? bxChord : byChord) : bassChord);
        tempChord.addAll(
            trebleIsSeparate ? (tIsX ? txChord : tyChord) : trebleChord);

        // set main timing
        double diffTiming = trebleGroove[treblePoint] < bassGroove[bassPoint]
            ? trebleGroove[treblePoint]
            : bassGroove[bassPoint];
        mainTiming += diffTiming;

        // set result
        resultChord.add(tempChord);
        resultGroove.add(diffTiming);

        // set chord item
        tIsX = !tIsX;

        // set played
        trebleTiming += trebleGroove[treblePoint];
        bassTiming += bassGroove[bassPoint];

        // choose which come first
        // treble first
        if (trebleGroove[treblePoint] < bassGroove[bassPoint]) {
          // if treble not last item
          if (treblePoint < trebleGroove.length - 1) {
            // set treble point
            treblePoint++;
          }
        }
        // bass first
        else if (trebleGroove[treblePoint] > bassGroove[bassPoint]) {
          // if not last item
          if (bassPoint < bassGroove.length - 1) {
            // set basspoint
            bassPoint++;
          }
        }
        // same
        else {
          // if treble not last item
          if (treblePoint < trebleGroove.length - 1) {
            // set treble point
            treblePoint++;
          }
          // if not last item
          if (bassPoint < bassGroove.length - 1) {
            // set basspoint
            bassPoint++;
          }
        }
      }
    }

    print('trebleTiming: ' + trebleTiming.toString());
    print('bassTiming: ' + bassTiming.toString());
    print('mainTiming: ' + mainTiming.toString());
    print(resultChord);
    print(resultGroove);
    return new PlayingSequenceObject(
        chordList: resultChord, timingList: resultGroove);
  }
}
