import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManagement {
  AudioManagement._privateConstructor();
  static final AudioManagement instance = AudioManagement._privateConstructor();

  AudioCache audioCache = AudioCache();

  List<String> files = [
    "audio/A2Piano.wav",
    "audio/A3Piano.wav",
    "audio/A4Piano.wav",
    "audio/A5Piano.wav",
    "audio/Ab2Piano.wav",
    "audio/Ab3Piano.wav",
    "audio/Ab4Piano.wav",
    "audio/Ab5Piano.wav",
    "audio/B2Piano.wav",
    "audio/B3Piano.wav",
    "audio/B4Piano.wav",
    "audio/B5Piano.wav",
    "audio/Bb2Piano.wav",
    "audio/Bb3Piano.wav",
    "audio/Bb4Piano.wav",
    "audio/Bb5Piano.wav",
    "audio/C2Piano.wav",
    "audio/C3Piano.wav",
    "audio/C4Piano.wav",
    "audio/C5Piano.wav",
    "audio/C6Piano.wav",
    "audio/D2Piano.wav",
    "audio/D3Piano.wav",
    "audio/D4Piano.wav",
    "audio/D5Piano.wav",
    "audio/Db2Piano.wav",
    "audio/Db3Piano.wav",
    "audio/Db4Piano.wav",
    "audio/Db5Piano.wav",
    "audio/E2Piano.wav",
    "audio/E3Piano.wav",
    "audio/E4Piano.wav",
    "audio/E5Piano.wav",
    "audio/Eb2Piano.wav",
    "audio/Eb3Piano.wav",
    "audio/Eb4Piano.wav",
    "audio/Eb5Piano.wav",
    "audio/F#2Piano.wav",
    "audio/F#3Piano.wav",
    "audio/F#4Piano.wav",
    "audio/F#5Piano.wav",
    "audio/F2Piano.wav",
    "audio/F3Piano.wav",
    "audio/F4Piano.wav",
    "audio/F5Piano.wav",
    "audio/G2Piano.wav",
    "audio/G3Piano.wav",
    "audio/G4Piano.wav",
    "audio/G5Piano.wav"
  ];

  void play(List<String> chord) async {
    //AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

    AudioPlayer.logEnabled = true;
    // var parseString = ['A2', "D3", "F3", "G3"];

    List<String> playList = new List<String>();

    for (var item in chord) {
      playList.add("audio/" + item + "Piano.wav");
    }

    for (var playItem in playList) {
      await audioCache.play(playItem, mode: PlayerMode.LOW_LATENCY);
    }

    // await audioCache.play("audio/D1.mp3", mode: PlayerMode.LOW_LATENCY);
    // await audioCache.play("audio/F1.mp3", mode: PlayerMode.LOW_LATENCY);
    // await audioCache.play("audio/G1.mp3", mode: PlayerMode.LOW_LATENCY);
  }
}
