import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/global_bloc/global_bloc.dart';
import 'package:studenthub/blocs/global_bloc/global_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/data/dto/authen/request_login.dart';
import 'package:studenthub/widgets/bulletWidget.dart';
import 'package:studenthub/widgets/customCheckboxWidget.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';
import '../../core/text_field_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyLogin = GlobalKey<FormBuilderState>();
  final _formForgotPassword = GlobalKey<FormBuilderState>();

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
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKeyLogin,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    // text: 'Welcome \n',
                    text: welcomeKey.tr(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                    children: [
                      TextSpan(
                        // text: 'Back',
                        text: backKey.tr(),
                        style: const TextStyle(
                          color: primaryColor, // Replace with your desired color
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  // 'Enter your details to login',
                  loginDescriptionKey.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                TextFieldFormCustom(
                  fillColor: Colors.white,
                  name: 'username',
                  // hintText: 'Username',
                  hintText: userNameKey.tr(),
                  initialValue: "buiquangthanh1709@gmail.com",
                  // initialValue: "nguyenthoaidangkhoa+15@gmail.com",
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
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
                  // hintText: 'Password',
                  hintText: passwordKey.tr(),
                  initialValue: 'Buiquangthanh@1709',
                  // initialValue: '@Khoa123',
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(8),
                    FormBuilderValidators.maxLength(20),
                    FormBuilderValidators.match(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        errorText: 'Password must contain at least 1 special character, such as &, %, TM, or E.'),
                  ]),
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
                  margin: const EdgeInsets.only(top: 10), // Replace 10 with your desired margin value
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const CustomCheckBox(),
                          ),
                          // Container(margin: EdgeInsets.only(left: 10), child: const GradientCheckBox(),),),
                          const SizedBox(width: 10), // Replace 10 with your desired width
                          Text(
                            // 'Remember me',
                            rememberMeKey.tr(),
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.only(
                                  top: 12,
                                  left: 12,
                                  right: 12,
                                  bottom: MediaQuery.of(context).viewInsets.bottom,
                                ),
                                decoration: BoxDecoration(
                                    // color: Colors.white,
                                    color:
                                        Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                child: FormBuilder(
                                  key: _formForgotPassword,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      // decoration:
                                      //     BoxDecoration(color: Colors.red),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                // 'Reset Password',
                                                resetPasswordTitleKey.tr(),
                                                style: theme.textTheme.bodyMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              const Spacer(),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: theme.colorScheme.grey?.withOpacity(0.4),
                                                    borderRadius: BorderRadius.circular(50)),
                                                padding: const EdgeInsets.all(3),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 24),
                                          Text(
                                            // 'Your password will be automatically reset by the system. Please check your email to receive the new password.',
                                            resetPasswordDescriptionKey.tr(),
                                          ),
                                          const SizedBox(height: 24),
                                          TextFieldFormCustom(
                                            fillColor: Colors.white,
                                            name: 'email',
                                            // hintText: 'Enter your email',
                                            hintText: enterEmailPlaceHolderKey.tr(),
                                            maxLines: null,
                                            keyboardType: TextInputType.multiline,
                                            validator: FormBuilderValidators.compose([
                                              FormBuilderValidators.required(),
                                              FormBuilderValidators.email(),
                                            ]),
                                            icon: FaIcon(
                                              FontAwesomeIcons.user,
                                              size: 16,
                                              color: theme.colorScheme.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 36),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // 'Password should not use  any other site.',
                                                passwordHintMsg.tr(),
                                              ),
                                              BulletList([
                                                // 'The password must have at least 8 characters.',
                                                // 'The password must contain at least 1 special character, such as &, %, TM, or E.',
                                                // 'The password must contain at least 3 different kinds of characters, such as uppercase letters, lowercase letter, numeric digits, and punctuation marks.',
                                                passwordHintDetailMsg1.tr(),
                                                passwordHintDetailMsg2.tr(),
                                                passwordHintDetailMsg3.tr(),
                                              ])
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_formForgotPassword.currentState?.saveAndValidate() ?? false) {
                                                context.read<GlobalBloc>().add(
                                                      ResetPasswordEvent(
                                                          email: _formForgotPassword.currentState?.value["email"]
                                                              as String,
                                                          onSuccess: () {
                                                            SnackBarService.showSnackBar(
                                                                content:
                                                                    // 'New password sent to your email',
                                                                    newPasswordSentMsg.tr(),
                                                                status: StatusSnackBar.success);
                                                            Navigator.pop(context);
                                                          }),
                                                    );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 16), // Adjust padding as needed
                                                minimumSize: const Size(double.infinity, 48) // Set minimum button size
                                                ),
                                            child: Text(
                                              // 'Reset Password',
                                              resetPasswordTitleKey.tr(),
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          // 'Forgot Password?',
                          forgotPasswordKey.tr(),
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]),
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
                      if (_formKeyLogin.currentState?.saveAndValidate() ?? false) {
                        context.read<AuthBloc>().add(
                              LoginEvent(
                                requestLogin: RequestLogin(
                                  email: _formKeyLogin.currentState!.fields['username']!.value.toString(),
                                  password: _formKeyLogin.currentState!.fields['password']!.value.toString(),
                                ),
                                onSuccess: () {
                                  AuthenState auth = context.read<AuthBloc>().state;
                                  if (auth.isCompanyRole() && auth.userModel.company == null) {
                                    context.pushNamed('company_create_profile');
                                  } else if (auth.isStudentRole() && auth.userModel.student == null) {
                                    context.pushNamed('student_create_profile_step_01');
                                  } else {
                                    context.pushNamed('home', queryParameters: {'welcome': 'true'});
                                  }
                                },
                                currentContext: context,
                              ),
                            );
                      }
                    },
                    child: Text(
                      // 'Login',
                      loginBtnKey.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
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
                      child: Text(
                          // "OR",
                          orKey.tr(),
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14, color: theme.colorScheme.grey))),
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
                // const Spacer(
                //   flex: 10,
                // ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      // text: 'Already have an account? ',
                      text: alreadyHaveAccountKey.tr(),
                      style: theme.textTheme.titleSmall?.copyWith(
                        // color: Colors.black54,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black54,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          // text: 'Sign Up',
                          text: signupBtnKey.tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushNamed('signup_01');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
