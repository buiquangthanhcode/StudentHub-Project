import 'package:flutter/material.dart';
import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/models/common/project_model.dart';

@immutable
abstract class ProjectEvent {}

class GetAllProjectsEvent extends ProjectEvent {
  final int companyId;
  GetAllProjectsEvent({required this.companyId});
}

class GetProjectEvent extends ProjectEvent {
  final Project newProject;
  GetProjectEvent(this.newProject);
}

class UpdateNewProjectEvent extends ProjectEvent {
  final Project newProject;
  UpdateNewProjectEvent(this.newProject);
}

class PostNewProjectEvent extends ProjectEvent {
  final Project newProject;
  final Function? onSuccess;
  PostNewProjectEvent({required this.newProject, this.onSuccess});
}

class DeleteProjectEvent extends ProjectEvent {
  final int companyId;
  final int projectId;
  final Function? onSuccess;
  DeleteProjectEvent(
      {required this.companyId, required this.projectId, this.onSuccess});
}
