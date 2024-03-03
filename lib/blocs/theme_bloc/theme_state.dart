import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemesState extends Equatable {
  final ThemeMode themeMode;

  const ThemesState({
    required this.themeMode,
  });

  ThemesState update({ThemeMode? themeMode}) {
    return ThemesState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object> get props => [
        themeMode,
      ];
}
