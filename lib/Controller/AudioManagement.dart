import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManagement {
  static void play() async {
    AudioCache audioCache = AudioCache();
    //AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

    AudioPlayer.logEnabled = true;
    var parseString = ['A0', "D1", "F1", "G1"];

    List<String> playList = new List<String>();

    for (var item in parseString) {
      playList.add("audio/" + item + ".mp3");
    }

    for (var playItem in playList) {
      await audioCache.play(playItem, mode: PlayerMode.LOW_LATENCY);
    }

    // await audioCache.play("audio/D1.mp3", mode: PlayerMode.LOW_LATENCY);
    // await audioCache.play("audio/F1.mp3", mode: PlayerMode.LOW_LATENCY);
    // await audioCache.play("audio/G1.mp3", mode: PlayerMode.LOW_LATENCY);
  }
}
