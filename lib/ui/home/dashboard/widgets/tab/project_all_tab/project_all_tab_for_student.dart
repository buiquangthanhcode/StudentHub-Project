import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_event.dart';
import 'package:studenthub/blocs/project_bloc/project_state.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/blocs/student_bloc/student_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/ui/home/dashboard/widgets/more_action_widget.dart';
import 'package:studenthub/ui/home/dashboard/widgets/project_item.dart';

class ProjectAllTabForStudent extends StatefulWidget {
  const ProjectAllTabForStudent({super.key});

  @override
  State<ProjectAllTabForStudent> createState() => _ProjectAllTabForStudentState();
}

class _ProjectAllTabForStudentState extends State<ProjectAllTabForStudent> {
  @override
  void initState() {
    super.initState();
    int userId = BlocProvider.of<StudentBloc>(context).state.student.id ?? -1;
    context.read<StudentBloc>().add(
          GetAllProjectProposal(userId: userId, onSuccess: () {}),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Active Proposal (5)',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Center(
                  child: ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ProjectItem(theme: theme, item: Project());
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Divider(),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Submitted proposal (${state.projectProposals.length})',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Center(
                  child: ListView.separated(
                    itemCount: state.projectProposals.length,
                    itemBuilder: (context, index) {
                      return ProjectItem(theme: theme, projectProposal: state.projectProposals[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Divider(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProjectProposalStudent extends StatefulWidget {
  final ThemeData theme;
  final Project item;
  const ProjectProposalStudent({super.key, required this.theme, required this.item});

  @override
  State<ProjectProposalStudent> createState() => _ProjectProposalStudentState();
}

class _ProjectProposalStudentState extends State<ProjectProposalStudent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: theme.colorScheme.grey?.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Senior Frontend Developer',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '(${'FinTech'})',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: primaryColor,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheetCustom(context,
                        widgetBuilder: MoreActionWidget(
                          // projectId: 0,
                          project: widget.item,
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.grey!.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.ellipsis,
                      size: 18,
                      color: theme.colorScheme.grey!,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Created 3 days ago',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Student are looking for',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Clear expectation about your project or deliverables',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
