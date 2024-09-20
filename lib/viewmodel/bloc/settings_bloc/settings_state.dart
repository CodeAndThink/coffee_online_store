import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final ThemeData themeData;
  final Locale locale;

  const SettingsState({required this.themeData, required this.locale});

  @override
  List<Object?> get props => [themeData, locale];
}
