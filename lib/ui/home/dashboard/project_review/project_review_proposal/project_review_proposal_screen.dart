import 'package:flutter/material.dart';
import 'package:studenthub/ui/home/dashboard/data/data_count.dart';
import 'package:studenthub/ui/home/dashboard/project_review/widget/project_proposal_item.dart';

class ProjectReviewProposal extends StatefulWidget {
  const ProjectReviewProposal({super.key});

  @override
  State<ProjectReviewProposal> createState() => _ProjectReviewProposalState();
}

class _ProjectReviewProposalState extends State<ProjectReviewProposal> {
  final data = getProposal();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
        itemBuilder: (context, index) {
          return ProposalItem(
            theme: theme,
            item: data[index],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: data.length);
  }
}
