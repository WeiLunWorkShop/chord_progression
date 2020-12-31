part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsChangeEvent extends SettingsEvent {
  SettingsChangeEvent();
}

class SettingsChordSelectEvent extends SettingsEvent {
  SettingsChordSelectEvent();
}

class SettingsChordButtonSelectEvent extends SettingsEvent {
  SettingsChordButtonSelectEvent();
}
