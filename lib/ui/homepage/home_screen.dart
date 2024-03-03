import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
            onPressed: () {},
            child: Text(hiKey.tr().toUpperCase()),
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
