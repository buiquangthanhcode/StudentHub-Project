// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/company/company_model.dart';

class ProjectState extends Equatable {
  final List<Project> projects;
  final Project projectCreation;

  ProjectState({
    required this.projects,
    required this.projectCreation,
  });

  @override
  List<Object?> get props => [projects, projectCreation];

  ProjectState update({
    List<Project>? projects,
    Project? project,
  }) {
    return ProjectState(
      projects: projects ?? this.projects,
      projectCreation: project ?? this.projectCreation,
    );
  }
}
