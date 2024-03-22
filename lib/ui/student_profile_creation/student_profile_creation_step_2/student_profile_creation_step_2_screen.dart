import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/ui/student_profile_creation/widget/create_project.dart';
import 'package:studenthub/utils/helper.dart';
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
              Row(
                children: [
                  const Text(
                    "Project",
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheetCustom(context, widgetBuilder: const CreateProject());
                    },
                    icon: const Icon(Icons.add),
                  )
                ],
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
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.grey?.withOpacity(0.2),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.projects[index].name,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context.read<StudentCreateProfileBloc>().add(
                                                  UpdateProjectEvent(project: state.projects[index], onSuccess: () {}),
                                                );
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context.read<StudentCreateProfileBloc>().add(
                                                  RemoveProjectEvents(project: state.projects[index], onSuccess: () {}),
                                                );
                                          },
                                          icon: const Icon(Icons.delete),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${formatDateTime(stringToDateTime(state.projects[index].startDate), format: 'MM/yyyy')} - ${formatDateTime(stringToDateTime(state.projects[index].endDate), format: 'MM/yyyy')}',
                                    ),
                                    Text(
                                      ', ${state.projects[index].duration.toString()} months',
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.projects[index].description,
                            ),
                            const Text('Skillset'),
                            const SizedBox(
                              height: 10,
                            ),
                            Builder(builder: (context) {
                              if (state.projects[index].skills.isNotEmpty) {
                                return Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  direction: Axis.horizontal,
                                  children: state.projects[index].skills
                                      .map((item) => Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(40),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    item.name,
                                                    style: theme.textTheme.bodyMedium?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                );
                              }
                              return const SizedBox();
                            }),
                          ],
                        ),
                      );
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
