import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/blocs/student_bloc/student_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/create_project_resume.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/project_resume_item.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class StudentProfileCreationStep02Screen extends StatefulWidget {
  const StudentProfileCreationStep02Screen({super.key});

  @override
  State<StudentProfileCreationStep02Screen> createState() =>
      _StudentProfileCreationStep02ScreenState();
}

class _StudentProfileCreationStep02ScreenState
    extends State<StudentProfileCreationStep02Screen> {
  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthBloc>().state.userModel.student?.id;
    context.read<StudentBloc>().add(GetAllExperience(userId: userId!.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(56, 56),
            shape: const CircleBorder(),
          ),
          onPressed: () {
            context.pushNamed('student_create_profile_step_03');
          },
          child: const Icon(Icons.arrow_forward),
        ),
      ),
      appBar: AppBar(
        title: Text(
          // 'Experiences',
          experiencesTitleKey.tr(),
          // style: const TextStyle(
          //   fontSize: 24,
          //   fontWeight: FontWeight.bold,
          // ),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
        ),
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              // color: Colors.white,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  // 'Tell us about your self and you will be on your way connect with real-world project',
                  editProfileDescriptionKey.tr(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      // "Project",
                      projectKey.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.grey?.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheetCustom(context,
                              widgetBuilder: const CreateProjectResume());
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<StudentBloc, StudentState>(
                  builder: (context, state) {
                    if (state.student.experiences?.isEmpty ?? false) {
                      return Center(
                        child: EmptyDataWidget(
                          // mainTitle: 'Student Create Profile',
                          // subTitle: 'No project found',
                          mainTitle: studentCreateProfileKey.tr(),
                          subTitle: noProjectFoundKey.tr(),
                          widthImage: 200,
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.student.experiences?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProjectResumeItem(
                            item: state.student.experiences![index]);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
