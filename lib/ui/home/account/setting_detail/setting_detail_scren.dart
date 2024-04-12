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
                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionDuration: const Duration(milliseconds: 200),
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return Dialog(
                                insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                                backgroundColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: FormBuilder(
                                    key: _formChangePassWord,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              'Change Password',
                                              style: theme.textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
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
                                        const SizedBox(height: 10),
                                        const TextFieldFormCustom(
                                            name: 'old_password',
                                            hintText: 'Old Password',
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
                                        const SizedBox(height: 10),
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
                                                    Navigator.pop(context);
                                                  }));
                                            }
                                          },
                                          child: const Text('Change Password'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
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
