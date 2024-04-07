import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/company_bloc/company_bloc.dart';
// import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/routes.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

GlobalKey<NavigatorState> navigatorKeys = GlobalKey<NavigatorState>(); //  Add by Quang Thanh

class StudentHub extends StatelessWidget {
  const StudentHub({super.key, this.themeStorage});
  final String? themeStorage;

  // Add by Quang Thanh
  static GlobalKey<NavigatorState>? _navigatorKey;
  static GlobalKey<NavigatorState> get navigatorKey {
    _navigatorKey ??= GlobalKey<NavigatorState>();
    navigatorKeys = _navigatorKey!;
    return _navigatorKey!;
  }

  static NavigatorState get navigatorState => navigatorKey.currentState!;
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemesBloc>(
          create: (BuildContext context) => ThemesBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<StudentBloc>(
          create: (BuildContext context) => StudentBloc(),
        ),
                BlocProvider<CompanyBloc>(
          create: (BuildContext context) => CompanyBloc(),
        ),
        // Add more bloc providers
      ],
      child: BlocBuilder<ThemesBloc, ThemesState>(
        builder: (context, state) {
          return MaterialApp.router(
            color: Colors.white,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            builder: EasyLoading.init(),
            scaffoldMessengerKey: scaffoldKey,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Student Hub',
            theme: state.themeMode == ThemeMode.dark
                ? AppThemes.darkTheme
                : AppThemes.lightTheme, // Using state.themeMode to change theme when event is dispatched
            routerConfig: router,
          );
        },
      ),
    );
  }
}
