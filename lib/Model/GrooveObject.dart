Map<String, GrooveObject> grooveList = {
  "𝅝": new GrooveObject(playLoopTimes: 1, playItems: [4]),
  "𝅗𝅥": new GrooveObject(playLoopTimes: 2, playItems: [2]),
  "𝅘𝅥": new GrooveObject(playLoopTimes: 4, playItems: [1]),
  "𝅗𝅥.": new GrooveObject(playLoopTimes: 1, playItems: [3, 1]),
  "𝅘𝅥𝅮𝅘𝅥𝅮𝅘𝅥𝅮𝅘𝅥𝅮":
      new GrooveObject(playLoopTimes: 2, playItems: [0.5, 0.5, 0.5, 0.5]),
  "𝅘𝅥𝅘𝅥𝅮𝅘𝅥𝅮": new GrooveObject(playLoopTimes: 2, playItems: [1, 0.5, 0.5]),
  "𝅘𝅥𝅮𝅘𝅥𝅮𝅘𝅥": new GrooveObject(playLoopTimes: 2, playItems: [0.5, 0.5, 1]),
  "𝅘𝅥𝅮𝅘𝅥𝅘𝅥𝅮": new GrooveObject(playLoopTimes: 2, playItems: [0.5, 1, 0.5]),
  "𝅘𝅥𝅯𝅘𝅥𝅯𝅘𝅥𝅯𝅘𝅥𝅯":
      new GrooveObject(playLoopTimes: 4, playItems: [0.25, 0.25, 0.25, 0.25]),
  "𝅘𝅥𝅮𝅘𝅥𝅯𝅘𝅥𝅯": new GrooveObject(playLoopTimes: 4, playItems: [0.5, 0.25, 0.25]),
  "𝅘𝅥𝅯𝅘𝅥𝅯𝅘𝅥𝅮": new GrooveObject(playLoopTimes: 4, playItems: [0.25, 0.25, 0.5]),
  "𝅘𝅥𝅯𝅘𝅥𝅮𝅘𝅥𝅯": new GrooveObject(playLoopTimes: 4, playItems: [0.25, 0.5, 0.25]),
};

class GrooveObject {
  int playLoopTimes = 1;
  List<double> playItems = [1];

  GrooveObject({this.playLoopTimes, this.playItems});

  GrooveObject getGrooveObject(String groove) {
    return grooveList[groove];
  }
}
