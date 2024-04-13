import 'package:flutter/material.dart';
import 'package:studenthub/models/common/project_model.dart';

@immutable
abstract class AllProjectEvent {}

class GetAllDataEvent extends AllProjectEvent {
  GetAllDataEvent();
}

class GetProjectDetail extends AllProjectEvent {
  final String id;
  GetProjectDetail({required this.id});
}

class GetFavoriteProject extends AllProjectEvent {
  final String studentId;
  GetFavoriteProject({required this.studentId});
}

class AddFavoriteProject extends AllProjectEvent {
  final String projectId;
  final String studentId;
  AddFavoriteProject({required this.studentId, required this.projectId});
}

class RemoveFavoriteProject extends AllProjectEvent {
  final String projectId;
  final String studentId;
  RemoveFavoriteProject({required this.studentId, required this.projectId});
}

class RemoveFavoriteProjectList extends AllProjectEvent {
  final Project project;
  RemoveFavoriteProjectList({required this.project});
}
