import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/ui/home/home_screen.dart';
import 'package:studenthub/ui/home/dashboard/dashboard.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation/profile_creation.dart';
import 'package:studenthub/ui/company_profile_creation/welcome_screen.dart';
import 'package:studenthub/ui/introduction/introduction_screen.dart';
import 'package:studenthub/ui/login/login_screen.dart';
import 'package:studenthub/ui/home/projects/project_saved/project_saved.dart';
import 'package:studenthub/ui/home/projects/project_search/project_search_page.dart';
import 'package:studenthub/ui/signup/signup_step01_screen.dart';
import 'package:studenthub/ui/signup/signup_step02_screen.dart';
import 'package:studenthub/ui/signup/switch_account_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'project_search',
          name: 'project_search',
          pageBuilder: (context, state) {
            return customTransitionPage(
                state.pageKey, const ProjectSearchPage());
          },
        ),
        GoRoute(
          path: 'project_saved',
          name: 'project_saved',
          pageBuilder: (context, state) {
            return customTransitionPage(state.pageKey, const ProjectSaved());
          },
        ),
      ],
    ),
    GoRoute(
      path: '/introduction',
      builder: (BuildContext context, GoRouterState state) {
        return const IntroductionScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/signup_01',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpStep01();
      },
    ),
    GoRoute(
      path: '/signup_02',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpStep02();
      },
    ),
    GoRoute(
      path: '/switch_account',
      builder: (BuildContext context, GoRouterState state) {
        return const SwitchAccount();
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const Dashboard();
      },
    ),
    GoRoute(
      path: '/profile_creation',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileCreation();
      },
    ),
    GoRoute(
      path: '/welcome_screen',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeScreen();
      },
    ),
  ],
);

CustomTransitionPage customTransitionPage(LocalKey key, Widget child) {
  return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 250),
      key: key,
      child: child,
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child);
      });
}
