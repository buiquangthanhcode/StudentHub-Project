// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/company/company_model.dart';

class ProjectState extends Equatable {
  final Project project;

  ProjectState({
    required this.project,
  });

  @override
  List<Object?> get props => [project];

  ProjectState update({
    Project? project,
  }) {
    return ProjectState(
      project: project ?? this.project,
    );
  }
}
