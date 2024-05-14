import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/constants/strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Column(
              children: [
                Text(
                  NAME_APP,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700, color: primaryColor),
                ),
                const Spacer(
                  flex: 2,
                ),
                Image.asset(
                  'lib/assets/images/welcome_image.png',
                  scale: 1.2,
                ),
                const Spacer(),
                Text(
                  'Welcome, Hai!',
                  style: textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Let\'s start with your first project post',
                  style: textTheme.bodySmall!.copyWith(color: colorTheme.grey),
                ),
                const Spacer(
                  flex: 3,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    context
                        .goNamed('home', queryParameters: {'welcome': 'true'});
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56)),
                  child: Text(
                    // 'Get Started!',
                    getStartedBtnKey.tr(),
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
