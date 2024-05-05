import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';

void showWelcomeDialog(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  var colorTheme = Theme.of(context).colorScheme;
  var screenSize = MediaQuery.of(context).size;

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              width: screenSize.width * 0.8,
              height: screenSize.height * 0.5,
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset(
                    'lib/assets/images/welcome_image_dialog.png',
                    width: screenSize.width * 0.5,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Text(
                    'Welcome to Student Hub',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Start searching and implementing real-world projects right now!',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall!.copyWith(color: colorTheme.grey),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Get Started!',
                      style: textTheme.bodyMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ));
}
