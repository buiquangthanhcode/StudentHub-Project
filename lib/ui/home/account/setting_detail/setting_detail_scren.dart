import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/data/dto/student/request_change_password.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/bulletWidget.dart';
import 'package:studenthub/widgets/dialog.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class SettingDetailScreen extends StatefulWidget {
  const SettingDetailScreen({super.key});

  @override
  State<SettingDetailScreen> createState() => _SettingDetailScreenState();
}

class _SettingDetailScreenState extends State<SettingDetailScreen> {
  final _formChangePassWord = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Map<String, dynamic>> dataSetting = [
      {
        'icon': FontAwesomeIcons.language,
        'name': 'Change Language',
        'key': 'language',
      },
      {
        'icon': FontAwesomeIcons.passport,
        'name': 'Change Password',
        'key': 'password',
      },
      {
        'icon': FontAwesomeIcons.bell,
        'name': 'Notification',
        'key': 'notification',
      },
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Setting Detail',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color.fromARGB(255, 160, 160, 160), width: 1)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...dataSetting.map(
                (e) => GestureDetector(
                  onTap: () {
                    switch (e['key']) {
                      case 'language':
                        break;
                      case 'password':
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                              height: MediaQuery.of(context).size.height * 0.85,
                              child: FormBuilder(
                                key: _formChangePassWord,
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
                                            'Change Password',
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
                                      const Text('Your new password must be different from your previous password.'),
                                      const SizedBox(height: 24),
                                      const TextFieldFormCustom(
                                          fillColor: Colors.white,
                                          name: 'old_password',
                                          hintText: 'Current Password',
                                          isPasswordText: true,
                                          obscureText: true,
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                          icon: Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          )),
                                      const SizedBox(height: 10),
                                      const TextFieldFormCustom(
                                          fillColor: Colors.white,
                                          name: 'new_password',
                                          hintText: 'New Password',
                                          isPasswordText: true,
                                          obscureText: true,
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                          icon: Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          )),
                                      const SizedBox(height: 10),
                                      const TextFieldFormCustom(
                                          fillColor: Colors.white,
                                          name: 'confirm_password',
                                          hintText: 'Confirm Password',
                                          isPasswordText: true,
                                          obscureText: true,
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                          icon: Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          )),
                                      const SizedBox(height: 36),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Password should not use on any other site.'),
                                          BulletList(const [
                                            'The password must have at least 8 characters.',
                                            'The password must contain at least 1 special character, such as &, %, TM, or E.',
                                            'The password must contain at least 3 different kinds of characters, such as uppercase letters, lowercase letter, numeric digits, and punctuation marks.',
                                          ])
                                        ],
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formChangePassWord.currentState?.saveAndValidate() ?? false) {
                                            logger.d((_formChangePassWord.currentState?.value));
                                            RequestChangePassWord changeRequest = RequestChangePassWord(
                                                oldPassword:
                                                    _formChangePassWord.currentState?.fields['old_password']?.value,
                                                newPassword:
                                                    _formChangePassWord.currentState?.fields['new_password']?.value,
                                                confirmPassword: _formChangePassWord
                                                    .currentState?.fields['confirm_password']?.value);
                                            context.read<StudentBloc>().add(ChangePassWordEvent(
                                                requestChangePassWordRequest: changeRequest,
                                                onSuccess: () {
                                                  SnackBarService.showSnackBar(
                                                      content: 'Password was updated successfully!',
                                                      status: StatusSnackBar.success);
                                                  Navigator.pop(context);
                                                }));
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding:
                                                const EdgeInsets.symmetric(vertical: 16), // Adjust padding as needed
                                            minimumSize: const Size(double.infinity, 48) // Set minimum button size
                                            ),
                                        child: Text(
                                          'Change Password',
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
                            );
                          },
                        );
                        break;
                      case 'notification':
                        break;
                      default:
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: e == dataSetting.last ? 0 : 1,
                                color: const Color.fromARGB(255, 220, 220, 220)))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 28,
                          child: FaIcon(
                            e['icon'] as IconData,
                            color: theme.colorScheme.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Text(
                          e['name'].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.grey,
                          ),
                        ),
                        const Spacer(),
                        FaIcon(
                          FontAwesomeIcons.angleRight,
                          size: 16,
                          color: theme.colorScheme.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
