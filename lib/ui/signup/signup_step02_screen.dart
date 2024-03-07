import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';
import 'package:studenthub/utils/logger.dart';

import '../../core/text_field_custom.dart';

class SignUpStep02 extends StatelessWidget {
  const SignUpStep02({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKeyLogin = GlobalKey<FormBuilderState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: backgroundHeaderAppBar,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                NAME_APP,
                style: theme.textTheme.titleMedium,
              ),
              GestureDetector(
                child: const Icon(Icons.person),
                onTap: () {
                  context.go('/switch_account');
                },
              ),
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
                  'Sign up as Compay',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextFieldFormCustom(
              name: 'fullnam',
              hintText: 'Fullname',
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
                  color: theme.colorScheme.smallBoxColor1,
                ),
              ),
            ),
            TextFieldFormCustom(
              name: 'address',
              hintText: 'Work email address',
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
                  color: theme.colorScheme.smallBoxColor1,
                ),
              ),
            ),
            TextFieldFormCustom(
              name: 'passwork',
              hintText: 'Password (8 or more characters)',
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
                  color: theme.colorScheme.smallBoxColor1,
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Text(
                  'I agree to the ',
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  'Terms of Service',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.smallBoxColor1,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shadowColor: theme.colorScheme.smallBoxColor1,
                elevation: 5,
                minimumSize: const Size(150, 40),
              ),
              onPressed: () {
                if (formKeyLogin.currentState?.saveAndValidate() ?? false) {
                  logger.d(formKeyLogin.currentState?.value);
                }
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
                    shadowColor: theme.colorScheme.smallBoxColor1,
                    elevation: 5,
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
