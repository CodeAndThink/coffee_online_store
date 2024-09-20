import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends SettingsEvent {}

class ChangeLanguageEvent extends SettingsEvent {
  final Locale locale;

  ChangeLanguageEvent(this.locale);

  @override
  List<Object?> get props => [locale];
}

class LoadSettingsEvent extends SettingsEvent {}




