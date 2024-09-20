import 'package:coffee_online_store/view/theme/theme.dart';
import 'package:coffee_online_store/viewmodel/bloc/settings_bloc/settings_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/settings_bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(SettingsState(
            themeData: AppTheme.lightTheme, locale: const Locale('en'))) {
    on<ToggleThemeEvent>(_onThemeChangeEvent);
    on<ChangeLanguageEvent>(_onChangeLanguageEvent);
    on<LoadSettingsEvent>(_onLoadSettingsEvent);
    add(LoadSettingsEvent());
  }

  Future<void> _onLoadSettingsEvent(
      LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    final localeString = prefs.getString('locale') ?? 'en';
    final locale = Locale(localeString);

    final themeData = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

    emit(SettingsState(themeData: themeData, locale: locale));
  }

  Future<void> _onThemeChangeEvent(
      ToggleThemeEvent event, Emitter<SettingsState> emit) async {
    final isDarkMode = state.themeData.brightness == Brightness.dark;
    final newTheme = isDarkMode ? AppTheme.lightTheme : AppTheme.darkTheme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', !isDarkMode);

    emit(SettingsState(themeData: newTheme, locale: state.locale));
  }

  Future<void> _onChangeLanguageEvent(
      ChangeLanguageEvent event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', event.locale.languageCode);

    emit(SettingsState(themeData: state.themeData, locale: event.locale));
  }
}
