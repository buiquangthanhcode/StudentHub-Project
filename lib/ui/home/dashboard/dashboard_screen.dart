import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/ui/home/dashboard/widgets/tab/project_all_tab/project_all_tab_for_company.dart';
import 'package:studenthub/ui/home/dashboard/widgets/tab/project_all_tab/project_all_tab_for_student.dart';
import 'package:studenthub/ui/home/dashboard/widgets/tab/project_archived_tab/project_archived_tab_for_company.dart';
import 'package:studenthub/ui/home/dashboard/widgets/tab/project_working_tab/project_working_tab_for_company.dart';
import 'package:studenthub/ui/home/dashboard/widgets/tab/project_working_tab/project_working_tab_for_student.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.welcome});
  final String welcome;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late AuthenState authSate;
  @override
  void initState() {
    super.initState();
    authSate = context.read<AuthBloc>().state;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.welcome == 'true') {
        showWelcomeDialog(context);
      }
    });
  }

  void showWelcomeDialog(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    var screenSize = MediaQuery.of(context).size;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              // backgroundColor: Colors.white,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.5,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      'lib/assets/images/welcome_image_dialog.png',
                      width: screenSize.width * 0.5,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      // 'Welcome to Student Hub',
                      welcomeDialogMsg.tr(),
                      style: textTheme.bodyLarge!.copyWith(
                          // color: Colors.black,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      // 'Start searching and implementing real-world projects right now!',
                      changeAccountNoticeMsgKey1.tr(),
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall!.copyWith(
                          // color: colorTheme.grey,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? colorTheme.grey
                                  : Colors.white),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        // 'Get Started!',
                        getStartedBtnKey.tr(),
                        style: textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthenState>(
      builder: (context, state) {
        return Scaffold(body: BlocBuilder<AuthBloc, AuthenState>(
          builder: (context, state) {
            return SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            // const Icon(Icons.event_note_rounded, size: 30),
                            // const SizedBox(width: 15),
                            Text(
                              yourProjectsKey.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      state.currentRole == UserRole.company
                          ? ElevatedButton.icon(
                              onPressed: () {
                                // context.push('/project_post/step_01');
                                context.push('/home/project_post/step_01');
                              },
                              icon:
                                  const FaIcon(FontAwesomeIcons.plus, size: 18),
                              label: Text(
                                postProjectKey.tr(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )
                          : const SizedBox()
                    ]),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: DefaultTabController(
                        length: state.currentRole == UserRole.company ? 3 : 2,
                        child: Column(
                          children: [
                            TabBar(
                              labelColor:
                                  primaryColor, // Set the color of the selected tab label
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w600), //
                              unselectedLabelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                              indicator: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: primaryColor, // Border color
                                    width: 2, // Border width
                                  ),
                                ),
                              ),

                              tabs: state.currentRole == UserRole.company
                                  ? [
                                      Tab(text: allProjectKey.tr()),
                                      Tab(text: workingKey.tr()),
                                      Tab(text: archivedKey.tr()),
                                    ]
                                  : [
                                      Tab(text: allProjectKey.tr()),
                                      Tab(text: workingKey.tr()),
                                    ],
                            ),
                            Expanded(
                              child: Builder(builder: (context) {
                                if (state.currentRole == UserRole.company) {
                                  return const TabBarView(
                                    children: [
                                      ProjectAllTabForCompany(),
                                      ProjectWorkingTabForCompany(),
                                      ProjectArchivedTabForCompany(),
                                    ],
                                  );
                                } else if (state.currentRole ==
                                    UserRole.student) {
                                  return const TabBarView(
                                    children: [
                                      ProjectAllTabForStudent(),
                                      ProjectWorkingTabForStudent(),
                                    ],
                                  );
                                }
                                return const SizedBox();
                              }),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            );
          },
        ));
      },
    );
  }
}
