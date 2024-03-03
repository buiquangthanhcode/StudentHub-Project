import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/routes.dart';

class StudentHub extends StatelessWidget {
  const StudentHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      title: 'Student Hub',
      theme: AppThemes.lightTheme,
      // themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
