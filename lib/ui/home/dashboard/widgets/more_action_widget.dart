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

    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
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
                case "view_proposal":
                  log("View Proposal");
                  break;
                case "view_message":
                  log("View Message");
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
                                  content: "Project was deleted successfully!");
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
    );
  }
}
