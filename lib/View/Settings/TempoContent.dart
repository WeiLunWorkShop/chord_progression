import 'package:chord_progression/Controller/Settings.dart';
import 'package:chord_progression/Model/AppConstant.dart';
import 'package:chord_progression/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempoContent extends StatefulWidget {
  final AppConstant instance;
  TempoContent({Key key, @required this.instance}) : super(key: key);
  @override
  _TempoContent createState() => _TempoContent();
}

class _TempoContent extends State<TempoContent> {
  bool _buttonPressed = false;
  bool _loopActive = false;

  void _counterLoop(bool isAdd) async {
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    int count = 0;
    while (_buttonPressed) {
      if (isAdd) {
        if (Settings.instance.currentTempo < 480) {
          setState(() => count < 10
              ? Settings.instance.currentTempo++
              : Settings.instance.currentTempo += 10);
          await Future.delayed(Duration(milliseconds: 100));
          count++;
        } else {
          setState(() => Settings.instance.currentTempo = 480);
          await Future.delayed(Duration(milliseconds: 100));
        }
      } else {
        if (Settings.instance.currentTempo > 60) {
          setState(() => count < 10
              ? Settings.instance.currentTempo--
              : Settings.instance.currentTempo -= 10);
          await Future.delayed(Duration(milliseconds: 100));
          count++;
        } else {
          setState(() => Settings.instance.currentTempo = 60);
          await Future.delayed(Duration(milliseconds: 100));
        }
      }
    }
    print('stoped');
    count = 0;
    _loopActive = false;
  }

  @override
  Widget build(BuildContext context) {
    double columnWidth = widget.instance.screenWidth / 11;

    // ignore: missing_return
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      // ignore: close_sinks
      final settingsBloc = BlocProvider.of<SettingsBloc>(context);

      if (state is SettingsOnEvent) {
        return Container(
            decoration: BoxDecoration(
                color: widget.instance.backgroundColor,
                border: widget.instance.mainBorder),
            height: 3 * widget.instance.screenHeight / 4,
            width: 9 * columnWidth,
            child: Row(children: [
              Container(
                  height: widget.instance.screenHeight / 3,
                  width: 3 * columnWidth,
                  child: Listener(
                    child: Icon(
                      Icons.remove,
                      size: 80.0,
                      color: widget.instance.mainColor,
                    ),
                    onPointerDown: (point) {
                      _buttonPressed = true;
                      _counterLoop(false);
                    },
                    onPointerUp: (point) {
                      _buttonPressed = false;
                      settingsBloc.add(SettingsChangeEvent());
                    },
                  )),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(0, 255, 255, 0.8), width: 3),
                      borderRadius: BorderRadius.circular(12)),
                  height: widget.instance.screenHeight / 3,
                  width: 3 * columnWidth,
                  child: Center(
                      child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: Settings.instance.currentTempo.toString() + 'BPM',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.instance.mainColor,
                            fontSize: 35)),
                  ))),
              Container(
                  height: widget.instance.screenHeight / 3,
                  width: (3 * columnWidth) - 2.0,
                  child: Listener(
                    child: Icon(
                      Icons.add,
                      size: 80.0,
                      color: widget.instance.mainColor,
                    ),
                    onPointerDown: (point) {
                      _buttonPressed = true;
                      _counterLoop(true);
                    },
                    onPointerUp: (point) {
                      _buttonPressed = false;
                      settingsBloc.add(SettingsChangeEvent());
                    },
                  )),
            ]));
      } else {
        settingsBloc.add(SettingsChangeEvent());
        return Container();
      }
    });
  }
}
