import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_event.dart';
import 'package:studenthub/constants/key_translator.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.setLocale(const Locale('en'));
              context.read<ThemesBloc>().add(ToggleLanguageEvent(context));
            },
            child: Text(
              englishKey.tr().toUpperCase(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.setLocale(const Locale('vi'));
              context.read<ThemesBloc>().add(ToggleLanguageEvent(context));
            },
            child: Text(
              vietnamesKey.tr().toUpperCase(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ThemesBloc>().add(ToggleThemeEvent());
            },
            child: const Text(
              "Chuyển đổi theme",
            ),
          ),
          Center(
            child: Text(
              hiKey.tr(),
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
