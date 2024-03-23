import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/ui/home/dashboard/project_review/project_reivew_hired/project_review_hired_screen.dart';
import 'package:studenthub/ui/home/dashboard/project_review/project_review_proposal/project_review_proposal_screen.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/chat_detail_screen.dart';
import 'package:studenthub/ui/home/messages/messages_screen.dart';
import 'package:studenthub/ui/home/projects/project_detail/project_detail_screen.dart';

class ProjectReviewDetailScreen extends StatefulWidget {
  const ProjectReviewDetailScreen({super.key});

  @override
  State<ProjectReviewDetailScreen> createState() => _ProjectReviewDetailScreenState();
}

class _ProjectReviewDetailScreenState extends State<ProjectReviewDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Review Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Senior fontend Developer (FinTech)',
                style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Expanded(
              child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // all borrder
                          border: Border.all(color: theme.colorScheme.grey!.withOpacity(0.2), width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TabBar(
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          labelColor: primaryColor, // Set the color of the selected tab label
                          labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600), //
                          unselectedLabelStyle:
                              Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: primaryColor, // Border color
                                width: 2, // Border width
                              ),
                            ),
                          ),

                          tabs: const [
                            Tab(text: 'Proposals'),
                            Tab(text: 'Details'),
                            Tab(text: 'Message'),
                            Tab(text: 'Hired'),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            ProjectReviewProposal(),
                            ProjectDetailScreen(
                              id: '1',
                              isHiddenAppbar: true,
                            ),
                            MessagesScreen(
                              isHiddenAppbar: true,
                            ),
                            ProjectDetailHiredScreen(),
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
