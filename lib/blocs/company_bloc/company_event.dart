import 'package:flutter/material.dart';
import 'package:studenthub/models/common/project_model.dart';

@immutable
abstract class CompanyEvent {}

String? employeeQuantity;
String? name;
String? website;
String? description;

class GetAllDataEvent extends CompanyEvent {
  final Function? onSuccess;
  GetAllDataEvent({this.onSuccess});
}

class SetEmployeeQuantityEvent extends CompanyEvent {
  final Function? onSuccess;
  SetEmployeeQuantityEvent({this.onSuccess});
}

class RemoveEmployeeQuantityEvent extends CompanyEvent {}

class GetProjectEvent extends CompanyEvent {
  final Project newProject;
  GetProjectEvent(this.newProject);
}

class UpdateNewProjectEvent extends CompanyEvent {
  final Project newProject;
  UpdateNewProjectEvent(this.newProject);
}

class PostNewProjectEvent extends CompanyEvent {
  final Project newProject;
  final Function? onSuccess;
  PostNewProjectEvent({required this.newProject, this.onSuccess});
}
