import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
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
              Text.rich(
                TextSpan(
                  text: 'Welcome \n',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Back',
                      style: TextStyle(
                        color: primaryColor, // Replace with your desired color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your details to login',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              TextFieldFormCustom(
                fillColor: Colors.white,
                name: 'username',
                hintText: 'Username',
                initialValue: "buiquangthanh1709@gmail.com",
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
              const SizedBox(height: 15),
              TextFieldFormCustom(
                isPasswordText: true,
                fillColor: Colors.white,
                name: 'password',
                hintText: 'Password',
                initialValue: 'Buiquangthanh@1709',
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
              Container(
                margin: const EdgeInsets.only(
                    top: 10), // Replace 10 with your desired margin value
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(150, 56),
                  ),
                  onPressed: () {
                    // validate form
                    if (_formKeyLogin.currentState?.saveAndValidate() ??
                        false) {
                      context.read<AuthBloc>().add(
                            LoginEvent(
                              requestLogin: RequestLogin(
                                email: _formKeyLogin
                                    .currentState!.fields['username']!.value
                                    .toString(),
                                password: _formKeyLogin
                                    .currentState!.fields['password']!.value
                                    .toString(),
                              ),
                              onSuccess: () {
                                context.pushNamed('home',
                                    queryParameters: {'welcome': 'true'});
                              },
                              currentContext: context,
                            ),
                          );
                    }
                  },
                  child: Text(
                    'Login',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(children: [
                Expanded(
                  child: Divider(
                    color: theme.colorScheme.grey, // Set the color to grey
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("OR",
                        style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: theme.colorScheme.grey))),
                Expanded(
                  child: Divider(
                    color: theme.colorScheme.grey, // Set the color to grey
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Image(
                      image: AssetImage('lib/assets/images/google.png'),
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      size: 45,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: const Image(
                      image: AssetImage('lib/assets/images/twitter.png'),
                      width: 45,
                      height: 45,
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.black54,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pushNamed('signup_01');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
