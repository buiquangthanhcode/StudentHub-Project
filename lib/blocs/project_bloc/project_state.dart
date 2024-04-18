// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/company/company_model.dart';

class ProjectState extends Equatable {
  final List<Project> allProjects;
  final List<Project> workingProjects;
  final List<Project> archivedProjects;
  final Project projectCreation;

  ProjectState({
    required this.allProjects,
    required this.workingProjects,
    required this.archivedProjects,
    required this.projectCreation,
  });

  @override
  List<Object?> get props => [
        allProjects,
        workingProjects,
        archivedProjects,
        projectCreation,
      ];

  ProjectState update({
    List<Project>? allProjects,
    List<Project>? workingProjects,
    List<Project>? archivedProjects,
    Project? projectCreation,
    Project? projectSelection,
  }) {
    return ProjectState(
      allProjects: allProjects ?? this.allProjects,
      workingProjects: workingProjects ?? this.workingProjects,
      archivedProjects: archivedProjects ?? this.allProjects,
      projectCreation: projectCreation ?? this.projectCreation,
    );
  }
}
