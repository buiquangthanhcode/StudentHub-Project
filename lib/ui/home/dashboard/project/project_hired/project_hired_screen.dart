import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_bloc.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_state.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/ui/home/dashboard/data/data_count.dart';
import 'package:studenthub/ui/home/dashboard/project/widget/project_proposal_item.dart';

class ProjectDetailHiredScreen extends StatefulWidget {
  const ProjectDetailHiredScreen({super.key, this.item, this.projectProposal});

  final Project? item;
  final ProjectProposal? projectProposal;

  @override
  State<ProjectDetailHiredScreen> createState() => _ProjectDetailHiredScreenState();
}

class _ProjectDetailHiredScreenState extends State<ProjectDetailHiredScreen> {
  final data = getProposal();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<GeneralProjectBloc, GeneralProjectState>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return ProposalItem(
                theme: theme,
                item: state.proposalList[index],
                activeSentButton: false,
                projectId: widget.item!.projectId.toString(),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: state.proposalList.length);
      },
    );
  }
}
