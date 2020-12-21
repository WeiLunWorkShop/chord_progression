import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManagement {
  static void play(List<String> chord) async {
    AudioCache audioCache = AudioCache();
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
