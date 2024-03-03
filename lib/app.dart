import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_event.dart';
import 'package:studenthub/blocs/theme_bloc/theme_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/routes.dart';

class StudentHub extends StatelessWidget {
  const StudentHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemesBloc>(
          create: (BuildContext context) => ThemesBloc(),
        ),
      ],
      child: BlocBuilder<ThemesBloc, ThemesState>(
        builder: (context, state) {
          final themesBloc = BlocProvider.of<ThemesBloc>(context);
          themesBloc.add(InitialThemeEvent());
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Student Hub',
            theme: AppThemes.lightTheme,
            themeMode: state.themeMode, // Using state.themeMode to change theme when event is dispatched
            routerConfig: router,
          );
        },
      ),
    );
  }
}
