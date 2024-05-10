import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/chat_bloc/chat_bloc.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/company_bloc/company_bloc.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_state.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_type.dart';
import 'package:studenthub/blocs/notification_bloc/notification_bloc.dart';
import 'package:studenthub/blocs/notification_bloc/notification_state.dart';
import 'package:studenthub/blocs/project_bloc/project_bloc.dart';
import 'package:studenthub/blocs/global_bloc/global_bloc.dart';
// import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/local_notification.dart';
import 'package:studenthub/routes.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';

GlobalKey<NavigatorState> navigatorKeys = GlobalKey<NavigatorState>(); //  Add by Quang Thanh

class StudentHub extends StatefulWidget {
  const StudentHub({super.key, this.themeStorage});
  final String? themeStorage;

  // Add by Quang Thanh
  static GlobalKey<NavigatorState>? _navigatorKey;
  static GlobalKey<NavigatorState> get navigatorKey {
    _navigatorKey ??= GlobalKey<NavigatorState>(debugLabel: 'root');
    navigatorKeys = _navigatorKey!;
    return _navigatorKey!;
  }

  static NavigatorState get navigatorState => navigatorKey.currentState!;

  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  State<StudentHub> createState() => _StudentHubState();
}

class _StudentHubState extends State<StudentHub> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      if (AppLifecycleState.paused == state) {
        //Your function
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<NavigatorStatusBloc>(
          create: (BuildContext context) => NavigatorStatusBloc(),
        ),
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
        BlocProvider<ProjectBloc>(
          create: (BuildContext context) => ProjectBloc(),
        ),
        BlocProvider<GeneralProjectBloc>(
          create: (BuildContext context) => GeneralProjectBloc(),
        ),
        BlocProvider<GlobalBloc>(
          create: (BuildContext context) => GlobalBloc(),
        ),
        BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(),
        ),
        BlocProvider<NotificationBloc>(
          create: (BuildContext context) => NotificationBloc(),
        ),
        // Add more bloc providers
      ],
      child: BlocBuilder<ThemesBloc, ThemesState>(
        builder: (context, state) {
          return MultiBlocListener(
            listeners: [
              BlocListener<NavigatorStatusBloc, NavigatorStatusState>(
                listener: (context, state) {
                  switch (state.navigatorType) {
                    case NavigatorType.splash:
                      StudentHub.navigatorKey.currentContext?.go('/splash');
                      break;
                    case NavigatorType.home:
                      StudentHub.navigatorKey.currentContext?.go('/home');
                      break;
                    case NavigatorType.unauthenticated:
                      StudentHub.navigatorKey.currentContext?.go('/login');
                      break;
                    case NavigatorType.intro:
                      StudentHub.navigatorKey.currentContext?.go('/intro');
                      break;
                    default:
                      break;
                  }
                },
              ),
            ],
            child: MaterialApp.router(
              color: Colors.white,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              builder: EasyLoading.init(),
              scaffoldMessengerKey: StudentHub.scaffoldKey,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              title: 'Student Hub',
              theme: state.themeMode == ThemeMode.dark
                  ? AppThemes.darkTheme
                  : AppThemes.lightTheme, // Using state.themeMode to change theme when event is dispatched
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }
}
