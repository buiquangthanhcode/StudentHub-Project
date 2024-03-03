import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/routes.dart';
import 'package:studenthub/utils/logger.dart';

class StudentHub extends StatelessWidget {
  const StudentHub({super.key, this.themeStorage});
  final String? themeStorage;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemesBloc>(
          create: (BuildContext context) => ThemesBloc(),
        ),
        // Add more bloc providers
      ],
      child: BlocBuilder<ThemesBloc, ThemesState>(
        builder: (context, state) {
          logger.d("ThemeMode: ${state.themeMode}"); // Using logger to debug console :D
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Student Hub',
            theme: state.themeMode == ThemeMode.dark ? AppThemes.darkTheme : AppThemes.lightTheme, // Using state.themeMode to change theme when event is dispatched
            routerConfig: router,
          );
        },
      ),
    );
  }
}
