import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';
import 'package:studenthub/utils/logger.dart';

import '../../core/text_field_custom.dart';

class SignUpStep02ScreenForStudent extends StatefulWidget {
  const SignUpStep02ScreenForStudent({super.key});

  @override
  State<SignUpStep02ScreenForStudent> createState() => _SignUpStep02State();
}

class _SignUpStep02State extends State<SignUpStep02ScreenForStudent> {
  bool isAcceptCondtion = false;
  final formKeyLogin = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          ),
      body: FormBuilder(
        key: formKeyLogin,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text.rich(
                    TextSpan(
                      text: 'Sign up as\n',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Student',
                          style: TextStyle(
                            color:
                                primaryColor, // Replace with your desired color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset(
                  'lib/assets/images/student.png',
                  fit: BoxFit.cover,
                  height: 230,
                ),
                const SizedBox(height: 48),
                TextFieldFormCustom(
                  fillColor: Colors.white,
                  name: 'fullname',
                  hintText: 'Fullname',
                  onTap: () {
                    Scrollable.ensureVisible(formKeyLogin.currentContext!,
                        duration: const Duration(milliseconds: 500));
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
                  fillColor: Colors.white,
                  name: 'address',
                  hintText: 'Email address',
                  icon: Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.envelope,
                      size: 16,
                      color: theme.colorScheme.grey,
                    ),
                  ),
                ),
                TextFieldFormCustom(
                  isPasswordText: true,
                  obscureText: true,
                  fillColor: Colors.white,
                  name: 'password',
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
                      color: theme.colorScheme.grey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Transform.scale(
                        scale: 1.2,
                        child: ListTileTheme(
                          horizontalTitleGap: 0.0,
                          child: CheckboxListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 25),
                            activeColor: primaryColor,
                            title: RichText(
                                text: TextSpan(
                              text: 'I agree to the ',
                              style: theme.textTheme.bodySmall,
                              children: [
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.grey,
                                  ),
                                ),
                              ],
                            )),
                            controlAffinity: ListTileControlAffinity.leading,
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            value: isAcceptCondtion,
                            onChanged: (value) {
                              setState(() {
                                isAcceptCondtion = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      minimumSize: const Size(150, 56),
                    ),
                    onPressed: () {
                      if (formKeyLogin.currentState?.saveAndValidate() ??
                          false) {
                        context.pushNamed('home',
                            queryParameters: {'welcome': 'true'});
                      }
                    },
                    child: Text(
                      'Create my account',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Looking for staff? ',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.pushNamed('signup_02_for_company');
                      },
                      child: Text(
                        'Apply as a company',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
