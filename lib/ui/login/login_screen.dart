import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';
import 'package:studenthub/utils/logger.dart';

import '../../core/text_field_custom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKeyLogin = GlobalKey<FormBuilderState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                NAME_APP,
                style: theme.textTheme.titleMedium,
              ),
              const Icon(Icons.person),
            ],
          ),
        ),
      ),
      body: FormBuilder(
        key: formKeyLogin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Center(
                child: Text(
                  'Login with StudentHub',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextFieldFormCustom(
              name: 'username',
              hintText: 'Username',
              icon: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.user,
                  size: 16,
                  color: primaryColor,
                ),
              ),
            ),
            TextFieldFormCustom(
              name: 'password',
              hintText: 'Password',
              icon: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.lock,
                  size: 16,
                  color: primaryColor,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // shadowColor: theme.colorScheme.smallBoxColor1,
                elevation: 0,
                minimumSize: const Size(150, 40),
              ),
              onPressed: () {
                // if (formKeyLogin.currentState?.saveAndValidate() ?? false) {
                //   logger.d(formKeyLogin.currentState?.value);
                // }
                context.push('/welcome_screen');
              },
              child: const Text('Login'),
            ),
            const Spacer(
              flex: 10,
            ),
            Column(
              children: [
                Text(
                  '______ Don\'t have an Student Hub acccount? ____',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // shadowColor: theme.colorScheme.smallBoxColor1,
                    elevation: 0,
                    minimumSize: const Size(150, 40),
                  ),
                  onPressed: () {
                    // Navigate to the second screen using a named route.
                    context.go('/signup_01');
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
