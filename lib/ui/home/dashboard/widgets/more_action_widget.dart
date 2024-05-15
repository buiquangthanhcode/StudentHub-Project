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
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/ui/home/dashboard/data/data_count.dart';
import 'package:studenthub/ui/home/dashboard/widgets/edit_posting_widget.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/dialog.dart';
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
    final dataHeader =
        authState.currentRole == UserRole.company ? getMoreActionHeader(theme) : getMoreActionHeaderForStudent(theme);

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
                            extra: {'item': widget.project, 'initTab': "0"} as Map<String, dynamic>)
                        : context.push('/project_student_detail',
                            extra: {'item': widget.project} as Map<String, dynamic>);
                    break;
                  case "view_messages":
                    context.push('/project_company_detail',
                        extra: {'item': widget.project, 'initTab': "2"} as Map<String, dynamic>);
                    break;
                  case "view_hired":
                    context.push('/project_company_detail',
                        extra: {'item': widget.project, 'initTab': "3"} as Map<String, dynamic>);
                    break;
                  case "view_job_posting":
                    log("View Job Posting");
                    authState.currentRole == UserRole.company
                        ? context.push('/project_company_detail',
                            extra: {'item': widget.project, 'initTab': "1"} as Map<String, dynamic>)
                        : context.push('/project_student_detail',
                            extra: {'item': widget.project} as Map<String, dynamic>);
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
                    int? companyId = BlocProvider.of<AuthBloc>(context).state.userModel.company!.id;
                    context.read<ProjectBloc>().add(
                          DeleteProjectEvent(
                              companyId: companyId!,
                              projectId: widget.project.id!,
                              onSuccess: () {
                                SnackBarService.showSnackBar(
                                  status: StatusSnackBar.success,
                                  // content: "Project was deleted successfully!",
                                  content: deleteProjectSuccessMsgKey.tr(),
                                );
                                Navigator.pop(context);
                              }),
                        );
                    break;
                  case "close_posting":
                    showDialogUpdateStatus(
                      context,
                      image: 'lib/assets/images/change_icon.png',
                      title: "Mark project status",
                      textButtom: "Thàn",
                      subtitle: thisActionCannotBeUndoneKey.tr(),
                    );

                    break;
                  case "start_working":
                    log("Start Working");
                    int? companyId = BlocProvider.of<AuthBloc>(context).state.userModel.company!.id;
                    context.read<ProjectBloc>().add(
                          StartWorkingProjectEvent(
                              companyId: companyId!,
                              updatedProject: Project.fromMap(
                                {
                                  'id': widget.project.id,
                                  'projectScopeFlag': widget.project.projectScopeFlag,
                                  'title': widget.project.title,
                                  'description': widget.project.description,
                                  'numberOfStudents': widget.project.numberOfStudents,
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

  Future<void> showDialogUpdateStatus(BuildContext context,
      {String? image, String? title, String? subtitle, Function? onSave, String? textButtom, double? sizeImage}) async {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              titlePadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration:
                    const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          image ?? 'lib/assets/images/welcome_image_dialog.png',
                          fit: BoxFit.cover,
                          width: sizeImage,
                          height: sizeImage,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          // title ?? 'Welcome to Student Hub',
                          title ?? welcomeDialogMsg.tr(),
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          subtitle ?? 'Some subtitle....',
                          textAlign: TextAlign.center,
                          style: textTheme.bodySmall!.copyWith(color: colorTheme.grey),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: const Size(double.infinity, 56),
                                  backgroundColor: cardinalColor.withOpacity(0.5),
                                ),
                                onPressed: () {
                                  int? companyId = BlocProvider.of<AuthBloc>(context).state.userModel.company!.id;
                                  logger.d(widget.project.id);
                                  context.read<ProjectBloc>().add(
                                        CloseProjectEvent(
                                            companyId: companyId!,
                                            updatedProject: Project.fromMap(
                                              {
                                                'id': widget.project.id,
                                                'projectScopeFlag': widget.project.projectScopeFlag,
                                                'title': widget.project.title,
                                                'description': widget.project.description,
                                                'numberOfStudents': widget.project.numberOfStudents,
                                                'typeFlag': 2,
                                                'status': 2
                                              },
                                            ),
                                            onSuccess: () {
                                              SnackBarService.showSnackBar(
                                                status: StatusSnackBar.success,
                                                // content: "Project was updated successfully!",
                                                content: projectUpdatedSuccessMsgKey.tr(),
                                              );
                                              Navigator.pop(context);
                                              Navigator.of(context).pop();

                                              context.read<ProjectBloc>().add(GetArchivedProjectsEvent());
                                            }),
                                      );
                                },
                                child: Text(
                                  "Failed",
                                  style:
                                      textTheme.bodyMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: const Size(double.infinity, 56),
                                  backgroundColor: fandangoColor.withOpacity(0.8),
                                ),
                                onPressed: () {
                                  int? companyId = BlocProvider.of<AuthBloc>(context).state.userModel.company!.id;
                                  logger.d(widget.project.id);
                                  context.read<ProjectBloc>().add(
                                        CloseProjectEvent(
                                            companyId: companyId!,
                                            updatedProject: Project.fromMap(
                                              {
                                                'id': widget.project.id,
                                                'projectScopeFlag': widget.project.projectScopeFlag,
                                                'title': widget.project.title,
                                                'description': widget.project.description,
                                                'numberOfStudents': widget.project.numberOfStudents,
                                                'typeFlag': 2,
                                                'status': 1
                                              },
                                            ),
                                            onSuccess: () {
                                              SnackBarService.showSnackBar(
                                                status: StatusSnackBar.success,
                                                // content: "Project was updated successfully!",
                                                content: projectUpdatedSuccessMsgKey.tr(),
                                              );
                                              Navigator.pop(context);
                                              context.read<ProjectBloc>().add(GetArchivedProjectsEvent());
                                              Navigator.of(context).pop();
                                            }),
                                      );
                                },
                                child: Text(
                                  "Success",
                                  style:
                                      textTheme.bodyMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: -5,
                      top: -5,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.grey?.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
