import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/data/dto/authen/request_register_account.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

import '../../core/text_field_custom.dart';

class SignUpStep02ScreenForStudent extends StatefulWidget {
  const SignUpStep02ScreenForStudent({super.key, this.role});

  final String? role;

  @override
  State<SignUpStep02ScreenForStudent> createState() => _SignUpStep02State();
}

class _SignUpStep02State extends State<SignUpStep02ScreenForStudent> {
  bool isAcceptCondtion = false;
  final formKeyLogin = GlobalKey<FormBuilderState>();

  void handleSubmit() {
    if (!isAcceptCondtion) {
      SnackBarService.showSnackBar(
          content: 'Please accept the terms of service',
          status: StatusSnackBar.info);
      return;
    }

    if ((formKeyLogin.currentState?.saveAndValidate() ?? false) &&
        isAcceptCondtion) {
      final requestRegisterAccount = RequestRegisterAccount(
        email:
            formKeyLogin.currentState?.fields['email']?.value.toString() ?? '',
        password:
            formKeyLogin.currentState?.fields['password']?.value.toString() ??
                '',
        fullname:
            formKeyLogin.currentState?.fields['fullname']?.value.toString() ??
                '',
        role: widget.role ?? "0",
      );
      context.read<AuthBloc>().add(RegisterAccount(
          requestRegister: requestRegisterAccount,
          onSuccess: () {
            SnackBarService.showSnackBar(
                content: 'Register successfully',
                status: StatusSnackBar.success);
            context.push('/login');
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                      // text: 'Sign up as\n',
                      text: signUpAsKey.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                      children: [
                        TextSpan(
                          // text: 'Student',
                          text: studentRoleKey.tr(),
                          style: const TextStyle(
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
                  // hintText: 'Fullname',
                  hintText: fullNameKey.tr(),
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
                  name: 'email',
                  // hintText: 'Email address',
                  hintText: emailAddressKey.tr(),
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
                  // hintText: 'Password (8 or more characters)',
                  hintText: passwordForRegisterKey.tr(),
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
                              // text: 'I agree to the ',
                              text: agreeToKey.tr(),
                              style: theme.textTheme.bodySmall,
                              children: [
                                TextSpan(
                                  // text: 'Terms of Service',
                                  text: termsOfServiceKey.tr(),
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
                    onPressed: handleSubmit,
                    child: Text(
                      // 'Create my account',
                      createAccountBtnKey.tr(),
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
                      // 'Looking for staff? ',
                      lookingForStaffKey.tr(),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.pushNamed('signup_02_for_company');
                      },
                      child: Text(
                        // 'Apply as a company',
                        applyAsCompanyKey.tr(),
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
