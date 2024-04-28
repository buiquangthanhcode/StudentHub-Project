import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/ui/home/dashboard/project/project_hired/project_hired_screen.dart';
import 'package:studenthub/ui/home/dashboard/project/project_proposal/project_proposal_screen.dart';
import 'package:studenthub/ui/home/messages/messages_screen.dart';
import 'package:studenthub/ui/home/projects/project_general_detail/project_general_detail_screen.dart';
import 'package:studenthub/utils/logger.dart';

class ProjectDetailCompanyView extends StatefulWidget {
  const ProjectDetailCompanyView(
      {super.key, this.item, this.projectProposal, this.initTab = 0});

  final Project? item;
  final ProjectProposal? projectProposal;
  final int initTab;

  @override
  State<ProjectDetailCompanyView> createState() =>
      _ProjectReviewDetailScreenState();
}

class _ProjectReviewDetailScreenState extends State<ProjectDetailCompanyView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AuthenState authState;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: widget.initTab);
    authState = context.read<AuthBloc>().state;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.e(widget.item);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          projectReviewDetailTitleKey.tr(),
          style: theme.textTheme.headlineSmall!.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Senior frontend Developer (FinTech)',
            //     style: theme.textTheme.bodyMedium!
            //         .copyWith(fontWeight: FontWeight.w600)),
            Row(children: [
              Text(
                widget.item?.title ?? '',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,
              ),
            ]),
            const SizedBox(height: 10),
            Expanded(
              child: DefaultTabController(
                  length: 4,
                  initialIndex: widget.initTab,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // all borrder
                          border: Border.all(
                              color: theme.colorScheme.grey!.withOpacity(0.2),
                              width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          labelColor:
                              primaryColor, // Set the color of the selected tab label
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w600), //
                          unselectedLabelStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: primaryColor, // Border color
                                width: 2, // Border width
                              ),
                            ),
                          ),

                          tabs: [
                            Tab(text: proposalsProjectReviewKey.tr()),
                            Tab(text: detailsProjectReviewKey.tr()),
                            Tab(text: messagesProjectReviewKey.tr()),
                            Tab(text: hiredProjectReviewKey.tr()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ProjectReviewProposal(
                              item: widget.item,
                              projectProposal: widget.projectProposal,
                            ),
                            Builder(builder: (context) {
                              return ProjectGeneralDetailScreen(
                                id: widget.item?.id.toString() ??
                                    widget.projectProposal!.project?.id
                                        .toString() ??
                                    "0",
                                isHiddenAppbar: true,
                                isFavorite: "false",
                              );
                            }),
                            const MessagesScreen(
                              isHiddenAppbar: true,
                            ),
                            ProjectDetailHiredScreen(
                              item: widget.item,
                              projectProposal: widget.projectProposal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
