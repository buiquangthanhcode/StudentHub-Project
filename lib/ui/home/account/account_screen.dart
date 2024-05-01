import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_bloc.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/widgets/dialog.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthenState>(
      builder: (context, state) {
        List<Map<String, dynamic>> dataSetting = [
          {
            'icon': FontAwesomeIcons.solidCircleUser,
            // 'name': 'Profiles',
            'name': profileKey.tr(),
            'route_name': state.currentRole == UserRole.company
                ? state.userModel.company == null
                    ? 'company_create_profile'
                    : 'company_edit_profile'
                : state.userModel.student == null
                    ? 'student_create_profile_step_01'
                    : 'student_create_profile_step_01',
          },
          {
            'icon': FontAwesomeIcons.gears,
            // 'name': 'Setting',
            'name': settingsKey.tr(),
            'route_name': 'setting_detail',
          },
          {
            'icon': FontAwesomeIcons.leftLong,
            // 'name': 'Log out',
            'name': logoutKey.tr(),
            'route_name': 'introduction',
          },
        ];
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Text(
                            // 'Account',
                            accountNavKey.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Theme(
                    data: ThemeData(
                      dividerColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      unselectedWidgetColor: primaryColor,
                      expansionTileTheme: const ExpansionTileThemeData(
                        backgroundColor: Colors.transparent,
                        collapsedBackgroundColor: Colors.transparent,
                      ),
                      colorScheme: const ColorScheme.light(
                        primary: Colors.black,
                        onPrimary: Colors.black,
                      ),
                    ),
                    child: StatefulBuilder(builder: (context, setState) {
                      return ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              state.currentRole == UserRole.student
                                  ? 'lib/assets/images/circle_avatar.png'
                                  : "lib/assets/images/circle_avatar.png",
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.currentRole == UserRole.student
                                      ? state.userModel.fullname ?? ''
                                      : state.userModel.company?.companyName ??
                                          'Anonymous',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Text(
                                //   state.currentRole == UserRole.student
                                //       ? 'Student'
                                //       : 'Company',
                                //   style: theme.textTheme.bodyMedium?.copyWith(
                                //     color: Colors.grey,
                                //   ),
                                // ),
                                Text(
                                  state.currentRole == UserRole.student
                                      ? studentRoleKey.tr()
                                      : companyRoleKey.tr(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: [
                          GestureDetector(
                            onTap: () {
                              // final subtitle_msg = state.currentRole ==
                              //         UserRole.student
                              //     ? 'Start searching and implementing real-world projects right now!'
                              //     : 'Start finding and hiring young talented students!';
                              final subtitleMsg =
                                  state.currentRole == UserRole.student
                                      ? changeAccountNoticeMsgKey1.tr()
                                      : changeAccountNoticeMsgKey2.tr();
                              showDialogCustom(context,
                                  image: 'lib/assets/images/change_account.png',
                                  // title: 'Do you want to change account?',
                                  title: changeAccountConfirmMsgKey.tr(),
                                  subtitle: subtitleMsg,
                                  // textButtom: 'Change your account',
                                  textButtom: changeAccountBtnKey.tr(),
                                  sizeImage: 50, onSave: () {
                                context.read<AuthBloc>().add(UpdateRoleEvents(
                                    role: state.currentRole == UserRole.student
                                        ? UserRole.company
                                        : UserRole.student));
                                context
                                    .read<StudentBloc>()
                                    .add(ResetBlocEvent());
                                SnackBarService.showSnackBar(
                                    // content: 'Change account successfully!',
                                    content: changeAccountSuccessMsgKey.tr(),
                                    status: StatusSnackBar.success);
                                Navigator.of(context).pop();
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      state.isAnonymus()
                                          ? 'lib/assets/images/circle_avatar.png'
                                          : 'lib/assets/images/circle_avatar.png',
                                      width: 40,
                                      height: 40,
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.currentRole == UserRole.student
                                          ? state.userModel.company
                                                  ?.companyName ??
                                              'Anonymous'
                                          : state.userModel.fullname ?? '',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Text(
                                    //   state.currentRole == UserRole.student
                                    //       ? 'Company'
                                    //       : "Student",
                                    //   style:
                                    //       theme.textTheme.bodyMedium?.copyWith(
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                    Text(
                                      state.currentRole == UserRole.student
                                          ? companyRoleKey.tr()
                                          : studentRoleKey.tr(),
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(
                                  flex: 4,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  Divider(
                    color: theme.colorScheme.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: const Color.fromARGB(255, 160, 160, 160),
                            width: 1)),
                    child: Column(
                      children: [
                        ...dataSetting.map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (e['route_name'] == 'introduction') {
                                context
                                    .read<StudentBloc>()
                                    .add(ResetBlocEvent());
                                context
                                    .read<GeneralProjectBloc>()
                                    .add(ResetBlocEvents());
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  context.pushNamed(e['route_name']);
                                });
                              } else {
                                context.pushNamed(e['route_name']);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 22, horizontal: 5),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: e == dataSetting.last ? 0 : 1,
                                          color: const Color.fromARGB(
                                              255, 220, 220, 220)))),
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
                                  if (e != dataSetting.last)
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
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.earListen,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          // 'How can we help you?',
                          helpBtnKey.tr(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
