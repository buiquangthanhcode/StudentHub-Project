import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/project_model.dart';

class AllProjectState extends Equatable {
  final List<Project> projectList;
  final Project projectDetail;

  AllProjectState({
    required this.projectList,
    required this.projectDetail,
  });

  @override
  // List<Object?> get props => [company, project];
  List<Object?> get props => [projectList, projectDetail];

  AllProjectState update({List<Project>? projectList, Project? projectDetail}) {
    return AllProjectState(
        projectList: projectList ?? this.projectList,
        projectDetail: projectDetail ?? this.projectDetail);
  }
}
