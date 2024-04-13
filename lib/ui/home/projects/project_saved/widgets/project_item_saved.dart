import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/all_project_bloc/all_project_bloc.dart';
import 'package:studenthub/blocs/all_project_bloc/all_project_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/utils/logger.dart';

class ProjectItemSaved extends StatefulWidget {
  const ProjectItemSaved({Key? key, required this.project}) : super(key: key);

  final Project project;
  @override
  State<ProjectItemSaved> createState() => _ProjectItemSavedState();
}

class _ProjectItemSavedState extends State<ProjectItemSaved> {
  int differentDay(String dateString) {
    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime ngayHienTai = DateTime.now();
    DateTime ngayDuocCungCap = format.parse(dateString);
    return ngayHienTai.difference(ngayDuocCungCap).inDays;
  }

  Map<int, String> time = {
    0: 'Less than 1 month',
    1: '1 - 3 months',
    2: '3 - 6 months',
    3: 'More than 6 months'
  };

  @override
  Widget build(BuildContext context) {
    // logger.d('Project: ${widget.project}');
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        context.pushNamed('project_detail',
            queryParameters: {'id': widget.project.id.toString()});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: colorTheme.hintColor!),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created ${differentDay(widget.project.createdAt!)} days ago',
                        style: textTheme.bodySmall!
                            .copyWith(color: colorTheme.grey),
                      ),
                      Text(
                        widget.project.title ??
                            'Senior frontend developer (Fintech)',
                        style:
                            textTheme.bodySmall!.copyWith(color: primaryColor),
                      ),
                      Text(
                        'Time: ${time[widget.project.projectScopeFlag] ?? '1-3 months'}, ${widget.project.numberOfStudents ?? 0} students needed',
                        style: textTheme.bodySmall!.copyWith(
                          color: colorTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    logger.d("test data: ${widget.project}");
                    context.read<AllProjectBloc>().add(
                        RemoveFavoriteProjectList(project: widget.project));
                    context.read<AllProjectBloc>().add(
                          RemoveFavoriteProject(
                            studentId: context
                                .read<AuthBloc>()
                                .state
                                .userModel
                                .student!
                                .id
                                .toString(),
                            projectId: widget.project.id.toString(),
                          ),
                        );
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: primaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Students are looking for',
              style: textTheme.bodySmall!,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: FaIcon(
                          FontAwesomeIcons.solidCircle,
                          size: 6,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          widget.project.description ??
                              'Clear expectation about your project or deliverables',
                          style: textTheme.bodySmall!,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text('Proposal: ${widget.project.countProposals ?? 'Less than 5'} ',
                style: textTheme.bodySmall!.copyWith(color: colorTheme.grey)),
          ],
        ),
      ),
    );
  }
}
