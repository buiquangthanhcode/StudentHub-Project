import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studenthub/app.dart';
import 'package:studenthub/core/easy_loading_config.dart';
import 'package:studenthub/core/local_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Locale currentLocale = const Locale('vi');
  final prefs = await SharedPreferences.getInstance();
  final String? currentLanguageStorage = prefs.getString('language');

  if (currentLanguageStorage != null) {
    currentLocale = Locale(currentLanguageStorage);
  } else {
    currentLocale = const Locale('en');
  }
  currentLocale = const Locale('en');
  await LocalNotification.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      fallbackLocale: currentLocale,
      startLocale: currentLocale,
      path: 'lib/assets/translations',
      child: StudentHub(
        themeStorage: currentLanguageStorage,
      ),
    ),
  );
  configEasyLoading();
}
