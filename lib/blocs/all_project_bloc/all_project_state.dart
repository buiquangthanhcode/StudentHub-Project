import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/project_model.dart';

class AllProjectState extends Equatable {
  final List<Project> projectList;

  AllProjectState({
    required this.projectList,
    // required this.project,
  });

  @override
  // List<Object?> get props => [company, project];
  List<Object?> get props => [projectList];
}
