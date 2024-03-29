import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/data/dto/authen/request_login.dart';
import 'package:studenthub/utils/logger.dart';
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
                obscureText: true,
                maxLines: null,
                keyboardType: TextInputType.multiline,
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
                          logger.d(_formKeyLogin.currentState!.value);
                          context.read<AuthBloc>().add(
                                LoginEvent(
                                    requestLogin: RequestLogin(
                                      email: _formKeyLogin.currentState!.fields['username']!.value.toString(),
                                      password: _formKeyLogin.currentState!.fields['password']!.value.toString(),
                                    ),
                                    onSuscess: () {
                                      context.pushReplacementNamed('home', queryParameters: {'welcome': 'true'});
                                    }),
                              );
                        }
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
