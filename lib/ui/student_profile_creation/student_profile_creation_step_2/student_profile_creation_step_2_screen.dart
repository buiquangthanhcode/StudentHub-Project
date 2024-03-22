import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/ui/student_profile_creation/widget/create_project_resume.dart';
import 'package:studenthub/ui/student_profile_creation/widget/project_resume_item.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class StudentProfileCreationStep02Screen extends StatefulWidget {
  const StudentProfileCreationStep02Screen({super.key});

  @override
  State<StudentProfileCreationStep02Screen> createState() => _StudentProfileCreationStep02ScreenState();
}

class _StudentProfileCreationStep02ScreenState extends State<StudentProfileCreationStep02Screen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(35, 25),
        ),
        onPressed: () {
          context.push('/student_create_profile/step_03');
        },
        child: Text(
          "Next",
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Experiences',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                'Tell us about your self and you will be on your way connect with real-worl project',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Project",
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
                        showModalBottomSheetCustom(context, widgetBuilder: const CreateProjectResume());
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
              BlocBuilder<StudentCreateProfileBloc, StudentCreateProfileState>(
                builder: (context, state) {
                  if (state.projects.isEmpty) {
                    return const EmptyDataWidget(
                      mainTitle: 'Student Create Profile',
                      subTitle: 'No project found',
                      widthImage: 200,
                    );
                  }
                  return ListView.builder(
                    itemCount: state.projects.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProjectResumeItem(item: state.projects[index]);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
