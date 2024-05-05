import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_event.dart';
import 'package:studenthub/blocs/project_bloc/project_state.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/ui/home/dashboard/widgets/project_item.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class ProjectArchivedTabForStudent extends StatefulWidget {
  const ProjectArchivedTabForStudent({super.key});

  @override
  State<ProjectArchivedTabForStudent> createState() => _ProjectAllTabState();
}

class _ProjectAllTabState extends State<ProjectArchivedTabForStudent> {
  List<Project> projects = [];
  @override
  void initState() {
    super.initState();
    context.read<ProjectBloc>().add(
          GetArchivedProjectsEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state.archivedProjects.isEmpty) {
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
          margin: const EdgeInsets.only(top: 20),
          child: Center(
            child: ListView.separated(
              itemCount: state.archivedProjects.length,
              itemBuilder: (context, index) {
                return ProjectItem(
                    theme: theme, item: state.archivedProjects[index]);
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
