import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManagement {
  AudioManagement._privateConstructor();
  static final AudioManagement instance = AudioManagement._privateConstructor();

  AudioCache audioCache = new AudioCache(prefix: 'assets/audio/');

  List<String> files = [
    "A2Piano.wav",
    "A3Piano.wav",
    "A4Piano.wav",
    "A5Piano.wav",
    "Ab2Piano.wav",
    "Ab3Piano.wav",
    "Ab4Piano.wav",
    "Ab5Piano.wav",
    "B2Piano.wav",
    "B3Piano.wav",
    "B4Piano.wav",
    "B5Piano.wav",
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
    "Db2Piano.wav",
    "Db3Piano.wav",
    "Db4Piano.wav",
    "Db5Piano.wav",
    "E2Piano.wav",
    "E3Piano.wav",
    "E4Piano.wav",
    "E5Piano.wav",
    "Eb2Piano.wav",
    "Eb3Piano.wav",
    "Eb4Piano.wav",
    "Eb5Piano.wav",
    "F#2Piano.wav",
    "F#3Piano.wav",
    "F#4Piano.wav",
    "F#5Piano.wav",
    "F2Piano.wav",
    "F3Piano.wav",
    "F4Piano.wav",
    "F5Piano.wav",
    "G2Piano.wav",
    "G3Piano.wav",
    "G4Piano.wav",
    "G5Piano.wav"
  ];

  void play(List<String> chord) async {
    AudioPlayer.logEnabled = false;
    List<String> playList = new List<String>();

    for (var item in chord) {
      playList.add(item + "Piano.wav");
    }

    for (var playItem in playList) {
      await this.audioCache.play(playItem, mode: PlayerMode.LOW_LATENCY);
    }

    // await audioCache.play("audio/D1.mp3", mode: PlayerMode.LOW_LATENCY);
    // await audioCache.play("audio/F1.mp3", mode: PlayerMode.LOW_LATENCY);
    // await audioCache.play("audio/G1.mp3", mode: PlayerMode.LOW_LATENCY);
  }
}
