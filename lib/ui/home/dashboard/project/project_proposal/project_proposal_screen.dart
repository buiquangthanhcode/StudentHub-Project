import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_bloc.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_event.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_state.dart';
import 'package:studenthub/data/dto/student/request_get_proposal_project.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/ui/home/dashboard/data/data_count.dart';
import 'package:studenthub/ui/home/dashboard/project/widget/project_proposal_item.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class ProjectReviewProposal extends StatefulWidget {
  const ProjectReviewProposal({
    super.key,
    this.item,
    this.projectProposal,
  });

  final Project? item;
  final ProjectProposal? projectProposal;

  @override
  State<ProjectReviewProposal> createState() => _ProjectReviewProposalState();
}

class _ProjectReviewProposalState extends State<ProjectReviewProposal> {
  final data = getProposal();

  @override
  void initState() {
    super.initState();
    final requestProposal = RequestProjectProposal(
      projectId: widget.item?.id.toString() ?? widget.projectProposal?.projectId.toString() ?? "0",
    );
    context
        .read<GeneralProjectBloc>()
        .add(GetAllProposalOfProjectEvent(requestProposal: requestProposal, onSuccess: () {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<GeneralProjectBloc, GeneralProjectState>(
      builder: (context, state) {
        if (state.proposalList.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmptyDataWidget(
                mainTitle: '',
                subTitle: 'No project proposal.',
                widthImage: MediaQuery.of(context).size.width * 0.5,
              ),
            ],
          );
        }
        return ListView.separated(
            itemBuilder: (context, index) {
              return ProposalItem(
                  theme: theme,
                  item: state.proposalList[index],
                  projectId: widget.item?.id.toString() ?? widget.projectProposal?.projectId.toString() ?? "0");
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: state.proposalList.length);
      },
    );
  }
}
