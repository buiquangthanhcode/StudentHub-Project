import 'package:flutter/material.dart';
import 'package:studenthub/models/common/project_model.dart';

@immutable
abstract class ProjectEvent {}

class GetAllProjectsEvent extends ProjectEvent {
  final int companyId;
  final Function? onSuccess;
  GetAllProjectsEvent({required this.companyId, this.onSuccess});
}

class GetWorkingProjectsEvent extends ProjectEvent {
  GetWorkingProjectsEvent();
}

class GetArchivedProjectsEvent extends ProjectEvent {
  GetArchivedProjectsEvent();
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

class EditProjectEvent extends ProjectEvent {
  final int companyId;
  final Project updatedProject;
  final Function? onSuccess;
  EditProjectEvent(
      {required this.companyId, required this.updatedProject, this.onSuccess});
}

class CloseProjectEvent extends ProjectEvent {
  final int companyId;
  final Project updatedProject;
  final Function? onSuccess;
  CloseProjectEvent(
      {required this.companyId, required this.updatedProject, this.onSuccess});
}

class StartWorkingProjectEvent extends ProjectEvent {
  final int companyId;
  final Project updatedProject;
  final Function? onSuccess;
  StartWorkingProjectEvent(
      {required this.companyId, required this.updatedProject, this.onSuccess});
}
