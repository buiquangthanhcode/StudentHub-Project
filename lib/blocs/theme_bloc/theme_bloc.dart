import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studenthub/blocs/theme_bloc/theme_event.dart';
import 'package:studenthub/blocs/theme_bloc/theme_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc()
      : super(
          const ThemesState(
            themeMode: ThemeMode.light,
          ),
        ) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<ToggleLanguageEvent>(_onToggleLanguage);
    on<InitialThemeEvent>(_onInitialTheme);
  }

  FutureOr<void> _onToggleTheme(ToggleThemeEvent event, Emitter<ThemesState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    if (state.themeMode == ThemeMode.dark) {
      prefs.setString("theme", "light");
      emit(state.update(themeMode: ThemeMode.light));
    } else {
      prefs.setString("theme", "dark");
      emit(state.update(themeMode: ThemeMode.dark));
    }
  }

  FutureOr<void> _onToggleLanguage(ToggleLanguageEvent event, Emitter<ThemesState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    if (event.context.locale.toString() == "en") {
      // ignore: use_build_context_synchronously
      await event.context.setLocale(const Locale("en"));
      prefs.setString("language", "en");
    } else {
      // ignore: use_build_context_synchronously
      await event.context.setLocale(const Locale("vi"));
      prefs.setString("language", "vi");
    }
  }

  FutureOr<void> _onInitialTheme(InitialThemeEvent event, Emitter<ThemesState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? currentTheme = prefs.getString("theme");
    if (currentTheme == null) {
      emit(state.update(themeMode: ThemeMode.system));
    } else {
      switch (currentTheme) {
        case "light":
          prefs.setString("theme", "light");
          emit(state.update(themeMode: ThemeMode.light));
          break;
        default:
          prefs.setString("theme", "dark");
          emit(state.update(themeMode: ThemeMode.dark));
          break;
      }
    }
  }
}
