part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsChangeEvent extends SettingsEvent {
  SettingsChangeEvent();
}

class SettingsChordButtonSelectEvent extends SettingsEvent {
  final String text;
  SettingsChordButtonSelectEvent(this.text);
}
