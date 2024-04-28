import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_bloc.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_event.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_state.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/bulletWidget.dart';

class ProjectGeneralDetailScreen extends StatefulWidget {
  const ProjectGeneralDetailScreen({super.key, required this.id, required this.isFavorite, this.isHiddenAppbar});

  final String id;
  final String isFavorite;
  final bool? isHiddenAppbar;

  @override
  State<ProjectGeneralDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectGeneralDetailScreen> {
  bool? isSaved;

  @override
  void initState() {
    super.initState();
    if (widget.isFavorite != 'null') {
      isSaved = widget.isFavorite == 'true';
    }
    context.read<GeneralProjectBloc>().add(
          GetProjectDetail(id: widget.id),
        );
  }

  Map<int, String> time = {0: 'Less than 1 month', 1: '1 - 3 months', 2: '3 - 6 months', 3: 'More than 6 months'};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    AuthenState authSate = context.read<AuthBloc>().state;

    return BlocBuilder<GeneralProjectBloc, GeneralProjectState>(
      builder: (BuildContext context, GeneralProjectState state) {
        bool isSubmitProposal = checkIsSubmitProposal(
            state.projectDetail.proposals ?? [], context.read<AuthBloc>().state.userModel.student!.id!.toInt());

        logger.d(isSubmitProposal);
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
                                          studentId: context.read<AuthBloc>().state.userModel.student!.id.toString(),
                                          projectId: widget.id,
                                        ),
                                      )
                                  : context.read<GeneralProjectBloc>().add(
                                        RemoveFavoriteProject(
                                          studentId: context.read<AuthBloc>().state.userModel.student!.id.toString(),
                                          projectId: widget.id,
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
                            isSaved! ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
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
                      state.projectDetail.title ?? 'Senior frontend developer (Fintech)',
                      style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
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
                          'Students are looking for',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.6),
                              ),
                        ),
                        BulletList([
                          state.projectDetail.description ?? 'Clear expectation about your project or deliverables',
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
                                'Project scope',
                                style: TextStyle(
                                  color: theme.colorScheme.brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.8),
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
                                    time[state.projectDetail.countProposals] ?? '3-6 months',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: theme.colorScheme.brightness == Brightness.dark
                                              ? Colors.white
                                              : Colors.black.withOpacity(0.8),
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
                                'Student required',
                                style: TextStyle(
                                    color: theme.colorScheme.brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.8)),
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
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: theme.colorScheme.brightness == Brightness.dark
                                            ? Colors.white
                                            : Colors.black.withOpacity(0.8)),
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
                    ? Opacity(
                        opacity: !isSubmitProposal ? 1 : 0.5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 56),
                          ),
                          onPressed: () {
                            if (!isSubmitProposal) {
                              context.push('/home/project_general_detail/submit_proposal', extra: state.projectDetail);
                            }
                          },
                          child: Text(
                            'Apply Now',
                            style: textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.brightness == Brightness.dark ? Colors.white : primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
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
