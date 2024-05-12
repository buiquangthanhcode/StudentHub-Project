import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:studenthub/app.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_event.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_type.dart';
import 'package:studenthub/services/local_services.dart';
import 'package:studenthub/utils/logger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    startSplashScreen();
  }

  startSplashScreen() async {
    String? token = await _getToken();
    if (mounted) {
      if (token == null) {
        context.read<NavigatorStatusBloc>().add(UpdateNavigatorStatusEvent(NavigatorType.unauthenticated));
      } else {
        context.read<AuthBloc>().add(
              GetInformationEvent(
                onSuccess: () {},
                onSuccessAuthenticated: (value) {
                  if (value) {
                    context.read<NavigatorStatusBloc>().add(UpdateNavigatorStatusEvent(NavigatorType.home));
                  } else {
                    context.read<NavigatorStatusBloc>().add(UpdateNavigatorStatusEvent(NavigatorType.unauthenticated));
                  }
                },
                accessToken: token ?? '',
                currentContext: context,
              ),
            );
      }
    }
  }

  Future<String?> _getToken() async {
    final LocalStorageService tokenService = LocalStorageService();
    final token = await tokenService.getAccessToken();
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('lib/assets/images/icon_splash.jpg'),
          ),
          const SizedBox(height: 50),
          Lottie.asset(
            'lib/assets/json/loading.json',
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
