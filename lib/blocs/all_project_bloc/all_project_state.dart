import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/project_model.dart';

class AllProjectState extends Equatable {
  final List<Project> projectList;
  final List<Project> projectFavorite;
  final Project projectDetail;

  AllProjectState({
    required this.projectList,
    required this.projectDetail,
    required this.projectFavorite,
  });

  @override
  // List<Object?> get props => [company, project];
  List<Object?> get props => [projectList, projectDetail, projectFavorite];

  AllProjectState update(
      {List<Project>? projectList,
      Project? projectDetail,
      List<Project>? projectFavorite}) {
    return AllProjectState(
      projectList: projectList ?? this.projectList,
      projectDetail: projectDetail ?? this.projectDetail,
      projectFavorite: projectFavorite ?? this.projectFavorite,
    );
  }
}
