import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';

class AllProjectState extends Equatable {
  final List<Project> projectList;
  final List<Project> projectFavorite;
  final Project projectDetail;
  final Set<String> projectSearchSuggestions;
  final List<Project> projectSearchList;

  final List<ProjectProposal> proposalList;

  AllProjectState({
    required this.projectList,
    required this.projectDetail,
    required this.projectFavorite,
    required this.projectSearchSuggestions,
    required this.projectSearchList,
    required this.proposalList,
  });

  @override
  // List<Object?> get props => [company, project];
  List<Object?> get props =>
      [projectList, projectDetail, projectFavorite, projectSearchSuggestions, projectSearchList, proposalList];

  AllProjectState update({
    List<Project>? projectList,
    Project? projectDetail,
    List<Project>? projectFavorite,
    Set<String>? projectSearchSuggestions,
    List<Project>? projectSearchList,
    List<ProjectProposal>? proposalList,
  }) {
    return AllProjectState(
      projectList: projectList ?? this.projectList,
      projectDetail: projectDetail ?? this.projectDetail,
      projectFavorite: projectFavorite ?? this.projectFavorite,
      projectSearchSuggestions: projectSearchSuggestions ?? this.projectSearchSuggestions,
      projectSearchList: projectSearchList ?? this.projectSearchList,
      proposalList: proposalList ?? this.proposalList,
    );
  }
}
