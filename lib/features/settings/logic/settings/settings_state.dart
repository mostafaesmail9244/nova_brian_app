part of 'settings_cubit.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}
final class ChangeThemeState extends SettingsState {}
