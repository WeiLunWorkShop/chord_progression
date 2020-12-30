part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsOnEvent extends SettingsState {
  const SettingsOnEvent();
}
