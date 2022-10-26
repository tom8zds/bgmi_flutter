part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class ModifyServerEvent extends SettingEvent {
  final String server;
  final String secret;

  ModifyServerEvent({required this.server, required this.secret});
}

class CheckServerEvent extends SettingEvent {}

class ChangeThemeModeEvent extends SettingEvent {}
