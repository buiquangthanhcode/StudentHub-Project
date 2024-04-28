import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/project_bloc/project_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/ui/home/dashboard/data/data_count.dart';
import 'package:studenthub/ui/home/dashboard/widgets/edit_posting_widget.dart';
import 'package:studenthub/utils/logger.dart';
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
    AuthenState authState = context.read<AuthBloc>().state;
    final dataHeader = authState.currentRole == UserRole.company
        ? getMoreActionHeader(theme)
        : getMoreActionHeaderForStudent(theme);

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
                    authState.currentRole == UserRole.company
                        ? context.push('/project_company_detail',
                            extra: {'item': widget.project, 'initTab': "0"}
                                as Map<String, dynamic>)
                        : context.push('/project_student_detail',
                            extra: {'item': widget.project}
                                as Map<String, dynamic>);
                    break;
                  case "view_messages":
                    log("View Messages");
                    context.push('/project_company_detail',
                        extra: {'item': widget.project, 'initTab': "2"}
                            as Map<String, dynamic>);
                    break;
                  case "view_hired":
                    log("View Hired");
                    context.push('/project_company_detail',
                        extra: {'item': widget.project, 'initTab': "3"}
                            as Map<String, dynamic>);
                    break;
                  case "view_job_posting":
                    log("View Job Posting");
                    logger.d(widget.project);
                    authState.currentRole == UserRole.company
                        ? context.push('/project_company_detail',
                            extra: {'item': widget.project, 'initTab': "1"}
                                as Map<String, dynamic>)
                        : context.push('/project_student_detail',
                            extra: {'item': widget.project}
                                as Map<String, dynamic>);
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
                                  'typeFlag': 2,
                                },
                              ),
                              onSuccess: () {
                                SnackBarService.showSnackBar(
                                  status: StatusSnackBar.success,
                                  // content: "Project was updated successfully!",
                                  content: projectUpdatedSuccessMsgKey.tr(),
                                );
                                Navigator.pop(context);
                                context
                                    .read<ProjectBloc>()
                                    .add(GetArchivedProjectsEvent());
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
                                  'typeFlag': 1,
                                },
                              ),
                              onSuccess: () {
                                SnackBarService.showSnackBar(
                                  status: StatusSnackBar.success,
                                  // content: "Project was updated successfully!",
                                  content: projectUpdatedSuccessMsgKey.tr(),
                                );
                                Navigator.pop(context);
                              }),
                        );
                    break;
                }
              },
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    width: 20,
                    height: 20,
                    child: dataHeader[index]['icon'] as Widget,
                  ),
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
