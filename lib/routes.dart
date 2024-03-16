// GoRouter configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/ui/dashboard_page/dashboard.dart';
import 'package:studenthub/ui/company_profile_creation/profile_creation/profile_creation.dart';
import 'package:studenthub/ui/company_profile_creation/welcome_screen.dart';
import 'package:studenthub/ui/homepage/home_screen.dart';
import 'package:studenthub/ui/login/login_screen.dart';
import 'package:studenthub/ui/post_a_project/dashboard/dashboard_screen.dart';
import 'package:studenthub/ui/post_a_project/step_1/project_post_step01_screen.dart';
import 'package:studenthub/ui/post_a_project/step_2/project_post_step02_screen.dart';
import 'package:studenthub/ui/post_a_project/step_3/project_post_step03_screen.dart';
import 'package:studenthub/ui/post_a_project/step_4/project_post_step04_screen.dart';
import 'package:studenthub/ui/project_page/project_page.dart';
import 'package:studenthub/ui/project_page/project_page_.dart';
import 'package:studenthub/ui/signup/signup_step01_screen.dart';
import 'package:studenthub/ui/signup/signup_step02_screen.dart';
import 'package:studenthub/ui/signup/switch_account_screen.dart';
import 'package:studenthub/ui/student_profile_creation/profile_input_step_3/profile_input_step_3.dart';
import 'package:studenthub/ui/student_profile_creation/student_profile_creation_step_1/student_profile_creation_step_1.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        // return const HomePageScreen();
        // return const LoginScreen();
        // return const ProjectPage();
        // return const DashboardScreen();
        return const ProjectPostStep01();
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
        GoRoute(
          path: 'signup_01',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpStep01();
          },
        ),
        GoRoute(
          path: 'signup_02',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpStep02();
          },
        ),
        GoRoute(
          path: 'switch_account',
          builder: (BuildContext context, GoRouterState state) {
            return const SwitchAccount();
          },
        ),
        GoRoute(
          path: 'dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return const Dashboard();
          },
        ),
        GoRoute(
          path: 'profile_creation',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileCreation();
          },
        ),
        GoRoute(
          path: 'welcome_screen',
          builder: (BuildContext context, GoRouterState state) {
            return const WelcomeScreen();
          },
        ),
        GoRoute(
          path: 'dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return const DashboardScreen();
          },
        ),
        GoRoute(
            path: 'project_post',
            builder: (BuildContext context, GoRouterState state) {
              return const SizedBox.shrink();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'step_01',
                builder: (BuildContext context, GoRouterState state) {
                  return const ProjectPostStep01();
                },
              ),
              GoRoute(
                path: 'step_02',
                builder: (BuildContext context, GoRouterState state) {
                  return const ProjectPostStep02();
                },
              ),
              GoRoute(
                path: 'step_03',
                builder: (BuildContext context, GoRouterState state) {
                  return const ProjectPostStep03();
                },
              ),
              GoRoute(
                path: 'step_04',
                builder: (BuildContext context, GoRouterState state) {
                  return const ProjectPostStep04();
                },
              ),
            ]),
      ],
    ),
  ],
);
