import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/blocs/student_bloc/student_state.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/ui/home/dashboard/widgets/project_item.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class ProjectWorkingTabForStudent extends StatefulWidget {
  const ProjectWorkingTabForStudent({super.key});

  @override
  State<ProjectWorkingTabForStudent> createState() => _ProjectAllTabState();
}

class _ProjectAllTabState extends State<ProjectWorkingTabForStudent> {
  List<Project> projects = [];
  @override
  void initState() {
    super.initState();
    int userId = BlocProvider.of<StudentBloc>(context).state.student.id ?? -1;
    context.read<StudentBloc>().add(GetWorkingProjectEvents(userId: userId, typeFlag: "1", onSuccess: () {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state.workingProject.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmptyDataWidget(
                mainTitle: '',
                subTitle: noProjectWorkingIndicatorKey.tr(),
                widthImage: MediaQuery.of(context).size.width * 0.5,
              ),
            ],
          );
        }
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Center(
            child: ListView.separated(
              itemCount: state.workingProject.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: ProjectItem(theme: theme, item: state.workingProject[index]),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Divider(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
