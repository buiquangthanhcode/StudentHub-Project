// GoRouter configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/ui/homepage/home_screen.dart';
import 'package:studenthub/ui/login/login_screen.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        // return const LoginScreen();
        return const ProfileCreation();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'homepage',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePageScreen();
          },
        ),
        // Add new more routes here
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
      ],
    ),
  ],
);
