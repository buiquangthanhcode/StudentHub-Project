import 'package:flutter/material.dart';
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
            color: Color(0xff030303),
            fontSize: 20,
            fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(
            color: Color(0xff030303),
            fontSize: 16,
            fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
            color: Color(0xff030303),
            fontSize: 14,
            fontWeight: FontWeight.w500),
        titleLarge: TextStyle(
            color: Color(0xff030303),
            fontSize: 24,
            fontWeight: FontWeight.w500),
        titleMedium: TextStyle(
            color: Color(0xff030303),
            fontSize: 20,
            fontWeight: FontWeight.w500),
        titleSmall: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
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
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(height: 0),
        border: defaultInputBorder,
        enabledBorder: defaultInputBorder,
        focusedBorder: defaultInputBorder,
        errorBorder: defaultInputBorder,
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
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            color: Color(0xff030303),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ));

  static final darkTheme = ThemeData(
      hintColor: Colors.grey,
      scaffoldBackgroundColor: const Color(0xff0C1421),
      colorScheme: const ColorScheme.dark(),
      primaryColor: primaryColor,
      primarySwatch: Colors.blue,
      fontFamily: 'Inter',
      useMaterial3: true,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        bodyMedium: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
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
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(height: 0),
        border: defaultInputBorder,
        enabledBorder: defaultInputBorder,
        focusedBorder: defaultInputBorder,
        errorBorder: defaultInputBorder,
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
          backgroundColor: primarySwatch,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
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
        backgroundColor: Color(0xff0C1421),
        foregroundColor: Color(0xff0C1421),
        elevation: 0,
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
      iconTheme: const IconThemeData(
        color: Colors.white,
      ));
}

final brightnesss =
    WidgetsBinding.instance.platformDispatcher.platformBrightness;

const defaultInputBorder = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 201, 201, 201)),
  borderRadius: BorderRadius.all(Radius.circular(8)),
);

// Add by Quang Thanh to custom color using extension
extension CustomColorSchemeX on ColorScheme {
  Color? get smallBoxColor1 =>
      brightness == Brightness.light ? Colors.blue : Colors.grey[400];
  Color? get smallBoxColor2 =>
      brightness == Brightness.light ? Colors.blue : Colors.grey[400];

  Color? get black =>
      brightness == Brightness.light ? const Color(0xff030303) : Colors.white;
  Color? get grey => brightness == Brightness.light
      ? const Color(0xff7C7C7C)
      : const Color(0xff7C7C7C);
  Color? get hintColor => brightness == Brightness.light
      ? const Color.fromARGB(255, 200, 200, 200)
      : const Color(0xff585858);
}

//And then access that property through Theme.of(context)... for example:
// Theme.of(context).colorScheme.smallBoxColor1