import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/blocs/theme_bloc/theme_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/data/dto/student/request_change_password.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/bulletWidget.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

enum LanguageProfile { vn, en }

enum ThemeProfile { light, dark }

class SettingDetailScreen extends StatefulWidget {
  const SettingDetailScreen({super.key});

  @override
  State<SettingDetailScreen> createState() => _SettingDetailScreenState();
}

class _SettingDetailScreenState extends State<SettingDetailScreen> {
  final _formChangePassWord = GlobalKey<FormBuilderState>();
  late LanguageProfile? langSelect;
  late ThemeProfile? themeSelect;

  Future<LanguageProfile> getCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') == 'en' ? LanguageProfile.en : LanguageProfile.vn;
  }

  Future<ThemeProfile> getCurrentTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme') == 'dark' ? ThemeProfile.dark : ThemeProfile.light;
  }

  @override
  void initState() {
    super.initState();
    getCurrentLanguage().then((value) {
      setState(() {
        langSelect = value;
      });
    });
    getCurrentTheme().then((value) {
      setState(() {
        themeSelect = value;
      });
    });
  }

  void changeLanguage(LanguageProfile? value) {
    setState(() {
      langSelect = value;
      if (value == LanguageProfile.vn) {
        context.setLocale(const Locale('vi'));
      } else if (value == LanguageProfile.en) {
        context.setLocale(const Locale('en'));
      }
      context.read<ThemesBloc>().add(ToggleLanguageEvent(context));
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      SnackBarService.showSnackBar(
          // content: 'Change language successfully!',
          content: changeLanguageSuccessMsgKey.tr(),
          status: StatusSnackBar.success);
      Navigator.pop(context, value);
    });
  }

  void changeTheme(ThemeProfile? value) {
    setState(() {
      themeSelect = value;
      if (value == ThemeProfile.light) {
        context.read<ThemesBloc>().add(ToggleThemeEvent());
      } else if (value == ThemeProfile.dark) {
        context.read<ThemesBloc>().add(ToggleThemeEvent());
      }
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      SnackBarService.showSnackBar(
          // content: 'Change theme successfully!',
          content: changeThemeSuccessMsgKey.tr(),
          status: StatusSnackBar.success);
      Navigator.pop(context, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Map<String, dynamic>> dataSetting = [
      {
        'icon': FontAwesomeIcons.language,
        // 'name': 'Change Language',
        'name': changeLanguageKey.tr(),
        'key': 'language',
      },
      {
        'icon': FontAwesomeIcons.passport,
        // 'name': 'Change Password',
        'name': changePasswordKey.tr(),
        'key': 'password',
      },
      {
        'icon': FontAwesomeIcons.themeco,
        // 'name': 'Change theme',
        'name': chatThemeKey.tr(),
        'key': 'theme',
      },
      {
        'icon': FontAwesomeIcons.bell,
        // 'name': 'Notification',
        'name': notificationKey.tr(),
        'key': 'notification',
      },
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          // 'Setting Detail',
          settingDetailsKey.tr(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
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
                        showModalBottomSheetCustom(context,
                            widgetBuilder: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        changeLanguageKey.tr(),
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
                                  const SizedBox(height: 24),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: langSelect == LanguageProfile.vn ? const Color(0xfff2f5f8) : Colors.white,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    child: RadioListTile<LanguageProfile>(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      value: LanguageProfile.vn,
                                      groupValue: langSelect,
                                      onChanged: changeLanguage,
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.asset(
                                              'lib/assets/images/vn.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Text(vietnameseKey.tr(), style: const TextStyle(color: Colors.black)),
                                        ],
                                      ),
                                      activeColor: primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: langSelect == LanguageProfile.en ? const Color(0xfff2f5f8) : Colors.white,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: RadioListTile<LanguageProfile>(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      value: LanguageProfile.en,
                                      groupValue: langSelect,
                                      onChanged: changeLanguage,
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Image.asset(
                                                'lib/assets/images/en.png',
                                                width: 30,
                                                height: 30,
                                              )),
                                          const SizedBox(width: 16),
                                          Text(englishKey.tr(), style: const TextStyle(color: Colors.black)),
                                        ],
                                      ),
                                      activeColor: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                        break;
                      case 'password':
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                                left: 12,
                                right: 12,
                                top: 12,
                              ),
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  color: theme.brightness == Brightness.dark ? Colors.black : Colors.white,
                                  // color: Colors.red,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                              // height: MediaQuery.of(context).size.height * 0.65,
                              child: SingleChildScrollView(
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
                                              // 'Change Password',
                                              changePasswordTitleKey.tr(),
                                              style: theme.textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color:
                                                    theme.brightness == Brightness.dark ? Colors.white : Colors.black,
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
                                            // 'Your new password must be different from your previous password.',
                                            passwordSuggestionMsg.tr(),
                                            style: TextStyle(
                                              color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
                                            )),
                                        const SizedBox(height: 24),
                                        TextFieldFormCustom(
                                            fillColor: Colors.white,
                                            name: 'old_password',
                                            // hintText: 'Current Password',
                                            hintText: currentPasswordPlacerHolderKey.tr(),
                                            isPasswordText: true,
                                            obscureText: true,
                                            maxLines: null,
                                            keyboardType: TextInputType.multiline,
                                            icon: Icon(
                                              Icons.lock,
                                              color: Colors.grey,
                                            )),
                                        const SizedBox(height: 10),
                                        TextFieldFormCustom(
                                            fillColor: Colors.white,
                                            name: 'new_password',
                                            // hintText: 'New Password',
                                            hintText: newPasswordPlacerHolderKey.tr(),
                                            isPasswordText: true,
                                            obscureText: true,
                                            maxLines: null,
                                            keyboardType: TextInputType.multiline,
                                            icon: Icon(
                                              Icons.lock,
                                              color: Colors.grey,
                                            )),
                                        const SizedBox(height: 10),
                                        TextFieldFormCustom(
                                            fillColor: Colors.white,
                                            name: 'confirm_password',
                                            // hintText: 'Confirm Password',
                                            hintText: confirmPasswordPlacerHolderKey.tr(),
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
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                                                        content:
                                                            // 'Password was updated successfully!',
                                                            passwordUpdatedMsg.tr(),
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
                                            // 'Change Password',
                                            changePasswordTitleKey.tr(),
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
                        break;
                      case 'notification':
                        break;
                      case 'theme':
                        showModalBottomSheetCustom(context,
                            widgetBuilder: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        // 'Change Theme',
                                        chatThemeKey.tr(),
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
                                  const SizedBox(height: 24),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: themeSelect == ThemeProfile.light ? const Color(0xfff2f5f8) : Colors.white,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    child: RadioListTile<ThemeProfile>(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      value: ThemeProfile.light,
                                      groupValue: themeSelect,
                                      onChanged: changeTheme,
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.asset(
                                              'lib/assets/images/light.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          // Text("Sáng"),
                                          Text(
                                            dayKey.tr(),
                                            style: const TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      activeColor: primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: themeSelect == ThemeProfile.dark ? const Color(0xfff2f5f8) : Colors.white,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: RadioListTile<ThemeProfile>(
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      value: ThemeProfile.dark,
                                      groupValue: themeSelect,
                                      onChanged: changeTheme,
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Image.asset(
                                                'lib/assets/images/dark.png',
                                                width: 30,
                                                height: 30,
                                              )),
                                          const SizedBox(width: 16),
                                          // Text("Tối"),
                                          Text(
                                            nightKey.tr(),
                                            style: const TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      activeColor: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ));
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
