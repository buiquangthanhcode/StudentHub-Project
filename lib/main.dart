import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studenthub/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Locale currentLocale = const Locale('vi');
  final prefs = await SharedPreferences.getInstance();
  final String? currentLanguageStorage = prefs.getString('language');

  if (currentLanguageStorage != null) {
    currentLocale = Locale(currentLanguageStorage);
  } else {
    currentLocale = const Locale('vi');
  }
  currentLocale = const Locale('en');
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      fallbackLocale: currentLocale,
      startLocale: currentLocale,
      path: 'lib/assets/translations',
      child: const StudentHub(),
    ),
  );
}
