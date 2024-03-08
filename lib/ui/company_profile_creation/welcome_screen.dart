import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            NAME_APP,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w700, color: primaryColor),
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
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
                style:
                    textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56)),
                child: Text(
                  'Get Started!',
                  style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(
                flex: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
