import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studenthub/constants/colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    hintColor: Colors.grey,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primaryColor: primaryColor,
    fontFamily: 'Inter',
    useMaterial3: true,
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
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 24,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ).apply(
      fontFamily: 'Inter',
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    dialogBackgroundColor: Colors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
    ),
    primaryColorLight: const Color(0xff1671BF),
    primaryColorDark: const Color(0xff4DADFF),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1,
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff228BE6),
        foregroundColor: Colors.white,
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
        backgroundColor: Colors.white,
        side: const BorderSide(
          width: 1,
          color: Color(0xff228BE6),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.white,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    hintColor: Colors.grey,
    scaffoldBackgroundColor: const Color(0xff5E5E5E),
    colorScheme: const ColorScheme.dark(),
    primaryColor: primaryColor,
    primarySwatch: Colors.blue,
    fontFamily: 'Inter',
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ).apply(
      fontFamily: 'Inter',
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    dialogBackgroundColor: Colors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
    ),
    primaryColorLight: const Color(0xff1671BF),
    primaryColorDark: const Color(0xff4DADFF),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1,
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff228BE6),
        foregroundColor: Colors.white,
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
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0.0,
      backgroundColor: Color(0xff5E5E5E),
      foregroundColor: Colors.white,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.white),
      toolbarTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
  );
}

extension CustomColorScheme on ColorScheme {
  Color get lightGrey => const Color(0xFFACACAC);
}
