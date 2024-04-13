import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/ui/home/dashboard/data/data_count.dart';
import 'package:studenthub/ui/home/dashboard/widgets/edit_posting_widget.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class MoreActionWidget extends StatefulWidget {
  // final int projectId;
  final Project project;
  // const MoreActionWidget({super.key, required this.projectId});
  const MoreActionWidget({super.key, required this.project});

  @override
  State<MoreActionWidget> createState() => _MoreActionWidgetState();
}

class _MoreActionWidgetState extends State<MoreActionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dataHeader = getMoreActionHeader(theme);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            height: 1,
            color: theme.colorScheme.grey!.withOpacity(0.1),
          );
        },
        shrinkWrap: true,
        itemCount: dataHeader.length,
        itemBuilder: ((context, index) {
          return Material(
            child: InkWell(
              onTap: () {
                final key = dataHeader[index]['key'];
                switch (key) {
                  case "view_proposals":
                    log("View Proposals");
                    break;
                  case "view_messages":
                    log("View Messages");
                    break;
                  case "view_hired":
                    log("View Hired");
                    break;
                  case "view_job_posting":
                    log("View Job Posting");
                    break;

                  case "edit_posting":
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return EditPosting(project: widget.project);
                      },
                    );
                    break;
                  case "remove_posting":
                    int? companyId = BlocProvider.of<AuthBloc>(context)
                        .state
                        .userModel
                        .company!
                        .id;
                    context.read<ProjectBloc>().add(
                          DeleteProjectEvent(
                              companyId: companyId!,
                              projectId: widget.project.id!,
                              onSuccess: () {
                                SnackBarService.showSnackBar(
                                    status: StatusSnackBar.success,
                                    content:
                                        "Project was deleted successfully!");
                                Navigator.pop(context);
                              }),
                        );
                    break;
                  case "close_posting":
                    log("Close Posting");
                    int? companyId = BlocProvider.of<AuthBloc>(context)
                        .state
                        .userModel
                        .company!
                        .id;
                    context.read<ProjectBloc>().add(
                          CloseProjectEvent(
                              companyId: companyId!,
                              updatedProject: Project.fromMap(
                                {
                                  'id': widget.project.id,
                                  'projectScopeFlag':
                                      widget.project.projectScopeFlag,
                                  'title': widget.project.title,
                                  'description': widget.project.description,
                                  'numberOfStudents':
                                      widget.project.numberOfStudents,
                                  'typeFlag': 1,
                                },
                              ),
                              onSuccess: () {
                                SnackBarService.showSnackBar(
                                    status: StatusSnackBar.success,
                                    content:
                                        "Project was updated successfully!");
                                Navigator.pop(context);
                              }),
                        );
                    break;
                  case "start_working":
                    log("Start Working");
                    int? companyId = BlocProvider.of<AuthBloc>(context)
                        .state
                        .userModel
                        .company!
                        .id;
                    context.read<ProjectBloc>().add(
                          StartWorkingProjectEvent(
                              companyId: companyId!,
                              updatedProject: Project.fromMap(
                                {
                                  'id': widget.project.id,
                                  'projectScopeFlag':
                                      widget.project.projectScopeFlag,
                                  'title': widget.project.title,
                                  'description': widget.project.description,
                                  'numberOfStudents':
                                      widget.project.numberOfStudents,
                                  'typeFlag': 0,
                                },
                              ),
                              onSuccess: () {
                                SnackBarService.showSnackBar(
                                    status: StatusSnackBar.success,
                                    content:
                                        "Project was updated successfully!");
                                Navigator.pop(context);
                              }),
                        );
                    break;
                }
              },
              child: Row(
                children: [
                  dataHeader[index]['icon'],
                  const SizedBox(width: 10),
                  Text(
                    dataHeader[index]['label'],
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
