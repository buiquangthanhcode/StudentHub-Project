import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_bloc.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_event.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_state.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/widgets/bulletWidget.dart';

class ProjectDetailStudentView extends StatefulWidget {
  const ProjectDetailStudentView({
    super.key,
    this.isFavorite,
    this.isHiddenAppbar,
    this.item,
    this.projectProposal,
  });

  final String? isFavorite;
  final bool? isHiddenAppbar;
  final Project? item;
  final ProjectProposal? projectProposal;

  @override
  State<ProjectDetailStudentView> createState() =>
      _ProjectDetailStudentViewState();
}

class _ProjectDetailStudentViewState extends State<ProjectDetailStudentView> {
  // Map<int, String> time = {
  //   0: 'Less than 1 month',
  //   1: '1 to 3 months',
  //   2: '3 to 6 months',
  //   3: 'More than 6 months'
  // };
  Map<int, String> time = {
    0: lessThan1MonthKey.tr(),
    1: oneToThreeMonthsKey.tr(),
    2: threeToSixMonthsKey.tr(),
    3: moreThan6MonthsKey.tr(),
  };
  @override
  void initState() {
    super.initState();
    if (widget.isFavorite != 'null') {
      isSaved = widget.isFavorite == 'true';
    }
    context.read<GeneralProjectBloc>().add(
          GetProjectDetail(
              id: widget.item?.id.toString() ??
                  widget.projectProposal!.project?.id.toString() ??
                  ''),
        );
  }

  bool? isSaved;
  // @override
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AuthenState authSate = context.read<AuthBloc>().state;

    return BlocBuilder<GeneralProjectBloc, GeneralProjectState>(
      builder: (BuildContext context, GeneralProjectState state) {
        return Scaffold(
          appBar: widget.isHiddenAppbar ?? false
              ? null
              : AppBar(
                  centerTitle: false,
                  titleSpacing: 0,
                  title: Text(
                    "Project detail",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  actions: [
                    if (widget.isFavorite != 'null')
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            isSaved = !isSaved!;
                            setState(() {
                              isSaved!
                                  ? context.read<GeneralProjectBloc>().add(
                                        AddFavoriteProject(
                                          studentId: context
                                              .read<AuthBloc>()
                                              .state
                                              .userModel
                                              .student!
                                              .id
                                              .toString(),
                                          projectId:
                                              widget.item?.id.toString() ??
                                                  widget.projectProposal!
                                                      .project?.id
                                                      .toString() ??
                                                  '',
                                        ),
                                      )
                                  : context.read<GeneralProjectBloc>().add(
                                        RemoveFavoriteProject(
                                          studentId: context
                                              .read<AuthBloc>()
                                              .state
                                              .userModel
                                              .student!
                                              .id
                                              .toString(),
                                          projectId:
                                              widget.item?.id.toString() ??
                                                  widget.projectProposal!
                                                      .project?.id
                                                      .toString() ??
                                                  '',
                                        ),
                                      );
                              // logger.d('IS FAVORITE $isSaved');
                              // context.read<AllProjectBloc>().add(
                              //     UpdateFavoriteProjectUI(
                              //         projectId: int.parse(widget.id),
                              //         isFavorite: isSaved!));
                            });
                          },
                          child: FaIcon(
                            isSaved!
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: primaryColor,
                          ),
                        ),
                      )
                  ],
                ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.projectDetail.title ??
                          'Senior frontend developer (Fintech)',
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 2, // Set the thickness of the divider
                      height: 20, // Set the height of the divider
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobDescriptionExampleKey.tr(),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                        ),
                        BulletList([
                          state.projectDetail.description ??
                              'Clear expectation about your project or deliverables',
                          // 'The skill required for your project',
                          // 'Detail about your project',
                        ]),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey, // Set the color of the divider
                      thickness: 2, // Set the thickness of the divider
                      height: 20, // Set the height of the divider
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.access_alarm, size: 42),
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                projectScopeKey.tr(),
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: FaIcon(
                                      FontAwesomeIcons.solidCircle,
                                      size: 6,
                                    ),
                                  ),
                                  Text(
                                    time[state.projectDetail.countProposals] ??
                                        '3-6 months',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.people, size: 42),
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                studentRequiredKey.tr(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: FaIcon(
                                      FontAwesomeIcons.solidCircle,
                                      size: 6,
                                    ),
                                  ),
                                  Text(
                                    '${state.projectDetail.numberOfStudents ?? '0'} students',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                // const SizedBox(height: 24),
                const Spacer(),
                authSate.currentRole == UserRole.student
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                        ),
                        onPressed: () {
                          context.push('/home/chat_detail');
                        },
                        child: Text(
                          'Messages',
                          style: textTheme.bodyMedium!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
