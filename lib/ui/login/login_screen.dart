import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';

import '../../core/text_field_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyLogin = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: const Center(
              child: SizedBox(),
            ),
          )),
      body: FormBuilder(
        key: _formKeyLogin,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome \nBack',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Sign in to continue',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              TextFieldFormCustom(
                name: 'username',
                hintText: 'Username',
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter password';
                  }
                  return '';
                },
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
                    color: theme.colorScheme.grey,
                  ),
                ),
              ),
              TextFieldFormCustom(
                name: 'password',
                hintText: 'Password',
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter password';
                  }
                  return '';
                },
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
                    color: theme.colorScheme.grey,
                  ),
                ),
              ),
              const Spacer(
                flex: 10,
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Create new account? ',
                      style: theme.textTheme.titleSmall?.copyWith(),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push('/signup_01');
                            },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: const Size(150, 56),
                      ),
                      onPressed: () {
                        // validate form
                        if (_formKeyLogin.currentState?.saveAndValidate() ?? false) {
                          // Navigate to the second screen using a named route.
                          context.push('/dashboard');
                        }

                        // Navigate to the second screen using a named route.
                      },
                      child: Text(
                        'Login',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
