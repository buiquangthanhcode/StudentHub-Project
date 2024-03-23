import 'package:flutter/material.dart';
import 'package:studenthub/ui/home/dashboard/data/data_count.dart';
import 'package:studenthub/ui/home/dashboard/project_review/widget/project_proposal_item.dart';

class ProjectDetailHiredScreen extends StatefulWidget {
  const ProjectDetailHiredScreen({super.key});

  @override
  State<ProjectDetailHiredScreen> createState() => _ProjectDetailHiredScreenState();
}

class _ProjectDetailHiredScreenState extends State<ProjectDetailHiredScreen> {
  final data = getProposal();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
        itemBuilder: (context, index) {
          return ProposalItem(
            theme: theme,
            item: data[index],
            activeSentButton: false,
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: data.length);
  }
}
