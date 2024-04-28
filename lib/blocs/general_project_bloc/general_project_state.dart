import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';

class GeneralProjectState extends Equatable {
  final List<Project> projectList;
  final List<Project> projectFavorite;
  final Project projectDetail;
  final Set<String> projectSearchSuggestions;
  final List<Project> projectSearchList;
  final List<ProjectProposal> proposalList;
  final List<ProjectProposal> proposalHireList;
  final bool isLoading;

  const GeneralProjectState({
    required this.projectList,
    required this.projectDetail,
    required this.projectFavorite,
    required this.projectSearchSuggestions,
    required this.projectSearchList,
    required this.proposalList,
    required this.proposalHireList,
    required this.isLoading,
  });

  @override
  // List<Object?> get props => [company, project];
  List<Object?> get props => [
        projectList,
        projectDetail,
        projectFavorite,
        projectSearchSuggestions,
        projectSearchList,
        proposalList,
        proposalHireList,
        isLoading,
      ];

  GeneralProjectState update({
    List<Project>? projectList,
    Project? projectDetail,
    List<Project>? projectFavorite,
    Set<String>? projectSearchSuggestions,
    List<Project>? projectSearchList,
    List<ProjectProposal>? proposalList,
    List<ProjectProposal>? proposalHireList,
    bool? isLoading,
  }) {
    return GeneralProjectState(
      projectList: projectList ?? this.projectList,
      projectDetail: projectDetail ?? this.projectDetail,
      projectFavorite: projectFavorite ?? this.projectFavorite,
      projectSearchSuggestions: projectSearchSuggestions ?? this.projectSearchSuggestions,
      projectSearchList: projectSearchList ?? this.projectSearchList,
      proposalList: proposalList ?? this.proposalList,
      proposalHireList: proposalHireList ?? this.proposalHireList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
