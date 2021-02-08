import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chord_progression/Controller/Settings.dart';
import 'package:chord_progression/Model/GrooveObject.dart';
import 'package:chord_progression/Model/PlayingSequenceObject.dart';

class AudioManagement {
  AudioManagement._privateConstructor();
  static final AudioManagement instance = AudioManagement._privateConstructor();

  AudioCache audioCache = new AudioCache(prefix: 'assets/audio/note/');
  AudioCache beatCache = new AudioCache(
      prefix: 'assets/audio/drumLoops/',
      fixedPlayer: new AudioPlayer(mode: PlayerMode.LOW_LATENCY));
  AudioPlayer beatPlayer = new AudioPlayer();

  List<String> notes = [
    "A1Piano.wav",
    "A2Piano.wav",
    "A3Piano.wav",
    "A4Piano.wav",
    "A5Piano.wav",
    "Ab2Piano.wav",
    "Ab3Piano.wav",
    "Ab4Piano.wav",
    "Ab5Piano.wav",
    "Ab6Piano.wav",
    "B1Piano.wav",
    "B2Piano.wav",
    "B3Piano.wav",
    "B4Piano.wav",
    "B5Piano.wav",
    "Bb1Piano.wav",
    "Bb2Piano.wav",
    "Bb3Piano.wav",
    "Bb4Piano.wav",
    "Bb5Piano.wav",
    "C2Piano.wav",
    "C3Piano.wav",
    "C4Piano.wav",
    "C5Piano.wav",
    "C6Piano.wav",
    "D2Piano.wav",
    "D3Piano.wav",
    "D4Piano.wav",
    "D5Piano.wav",
    "D6Piano.wav",
    "Db2Piano.wav",
    "Db3Piano.wav",
    "Db4Piano.wav",
    "Db5Piano.wav",
    "Db6Piano.wav",
    "E2Piano.wav",
    "E3Piano.wav",
    "E4Piano.wav",
    "E5Piano.wav",
    "E6Piano.wav",
    "Eb2Piano.wav",
    "Eb3Piano.wav",
    "Eb4Piano.wav",
    "Eb5Piano.wav",
    "Eb6Piano.wav",
    "F#2Piano.wav",
    "F#3Piano.wav",
    "F#4Piano.wav",
    "F#5Piano.wav",
    "F#6Piano.wav",
    "F2Piano.wav",
    "F3Piano.wav",
    "F4Piano.wav",
    "F5Piano.wav",
    "F6Piano.wav",
    "G2Piano.wav",
    "G3Piano.wav",
    "G4Piano.wav",
    "G5Piano.wav",
    "G6Piano.wav"
  ];

  List<String> drumLoops = [
    "Blues.wav",
    "Electro.wav",
    "Funk.wav",
    "Hip-Hop.wav",
    "House.wav",
    "Jazz.wav",
    "Latin.wav",
    "Techno.wav"
  ];

  Map<String, String> currentAudioMapList = {};

  Future<void> loadAllWithSilence() async {
    for (var playItem in notes) {
      await this
          .audioCache
          .play(playItem, mode: PlayerMode.LOW_LATENCY, volume: 0.0);
    }
  }

  void play(List<String> chord) async {
    AudioPlayer.logEnabled = false;
    List<String> playList = new List<String>();

    for (var item in chord) {
      playList.add(item + "Piano.wav");
    }

    for (var playItem in playList) {
      await this.audioCache.play(playItem, mode: PlayerMode.LOW_LATENCY).then(
          (audioPlayer) => this
              .currentAudioMapList
              .putIfAbsent(audioPlayer.playerId, () => playItem));
    }
  }

  Future<void> playWithGrooves(
      List<String> chord, String groove, int tempo) async {
    GrooveObject playGroove = new GrooveObject().getGrooveObject(groove);
    Settings.instance.currentPlayActionCount++;
    int currentCount = Settings.instance.currentPlayActionCount;

    List<String> xChord = new List<String>();
    List<String> yChord = new List<String>();
    if (["𝅗𝅥", "𝅘𝅥", "𝅗𝅥."].contains(groove)) {
      for (int note = 0; note < chord.length; note++) {
        if (note.isOdd)
          xChord.add(chord[note]);
        else
          yChord.add(chord[note]);
      }
    }

    bool isX = true;
    for (int loopCount = 0; loopCount < playGroove.playLoopTimes; loopCount++) {
      for (int i = 0; i < playGroove.playItems.length; i++) {
        AudioPlayer.players
            .forEach((playerId, audioPlayer) => audioPlayer.stop());

        if (["𝅗𝅥", "𝅘𝅥", "𝅗𝅥."].contains(groove)) {
          if (isX)
            play(xChord);
          else
            play(yChord);
          isX = !isX; // flip to other chord
        } else
          play(chord);

        await Future.delayed(Duration(
            milliseconds: (getTempo(tempo.toDouble()) * playGroove.playItems[i])
                .round()));

        // changed player
        if (Settings.instance.currentPlayState != 1 &&
            currentCount != Settings.instance.currentPlayActionCount) {
          break;
        }
      }
      // changed player
      if (Settings.instance.currentPlayState != 1 &&
          currentCount != Settings.instance.currentPlayActionCount) {
        break;
      }
    }

    Settings.instance.currentPlayActionCount = 0;
  }

  double getTempo(double tempo) {
    return ((60 / tempo) * 1000);
  }

  Future<void> playAllWithGrooves(PlayingSequenceObject playSequence) async {
    print(playSequence.chordList);
    print(playSequence.timingList);
    for (int i = 0; i < playSequence.chordList.length; i++) {
      play(playSequence.chordList[i]);

      AudioPlayer.players.forEach((playerId, audioPlayer) => {
            if (currentAudioMapList.containsKey(playerId))
              {
                if (playSequence.chordList[i].contains(
                    currentAudioMapList[playerId].replaceAll("Piano.wav", "")))
                  {audioPlayer.stop()}
              }
          });

      await Future.delayed(Duration(
          milliseconds: (getTempo(Settings.instance.currentTempo.toDouble()) *
                  playSequence.timingList[i])
              .round()));

      // paused
      if (Settings.instance.currentPlayState == 2) {
        Settings.instance.tempChordIndex = i;
        break;
      } else if (i == Settings.instance.chordList.length - 1) {
        Settings.instance.pausePoint.stop();
        Settings.instance.pausePoint.reset();
      }
    }
  }

  // void playDrum(String beat) async {
  //   if (beat == "") return;

  //   //await this.beatCache.play(beat + ".wav", mode: PlayerMode.LOW_LATENCY);
  // }

  // void playDrumLoop(String beat) async {
  //   this.beatPlayer.stop();
  //   if (beat == "") return;

  //   //this.beatPlayer =
  //   await this.beatCache.loop(beat + ".wav", playbackRate: 2.0);
  //   //this.beatPlayer.setPlaybackRate(playbackRate: 2.0);
  // }
}
