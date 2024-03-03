import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:studenthub/constants/colors.dart';

final brightnesss = SchedulerBinding.instance.window.platformBrightness;

class AppThemes {
  static final lightTheme = ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ).apply(fontFamily: 'Inter', bodyColor: Colors.black, displayColor: Colors.black),
      scaffoldBackgroundColor: Colors.black,
      dialogBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0.0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: primaryColor),
      primaryColor: primaryColor,
      primarySwatch: Colors.blue,
      fontFamily: 'Inter',
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff228BE6),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          alignment: Alignment.center,
          elevation: 0,
          backgroundColor: Colors.black,
          side: const BorderSide(
            width: 1,
            color: Color(0xff228BE6),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ));

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff121212),
    colorScheme: const ColorScheme.dark(),
    primaryColor: primaryColor,
    primarySwatch: Colors.blue,
    fontFamily: 'Inter',
    // useMaterial3: true,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    ).apply(
      fontFamily: 'Inter',
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff228BE6),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        alignment: Alignment.center,
        elevation: 0,
        backgroundColor: Colors.black,
        side: const BorderSide(
          width: 1,
          color: Color(0xff228BE6),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );
}

extension CustomColorScheme on ColorScheme {
  Color get lightGrey => const Color(0xFFACACAC);
}
