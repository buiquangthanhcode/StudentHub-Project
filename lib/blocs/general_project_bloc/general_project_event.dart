import 'package:flutter/material.dart';
import 'package:studenthub/data/dto/student/request_get_proposal_project.dart';
import 'package:studenthub/models/common/project_model.dart';

@immutable
abstract class GeneralProjectEvent {}

class GetAllDataEvent extends GeneralProjectEvent {
  GetAllDataEvent();
}

class GetAllSearchTitleEvent extends GeneralProjectEvent {
  final Function? onSuccess;

  GetAllSearchTitleEvent(this.onSuccess);
}

class GetSearchFilterDataEvent extends GeneralProjectEvent {
  final String? title;
  final int? projectScopeFlag;
  final int? numberOfStudents;
  final int? proposalsLessThan;
  GetSearchFilterDataEvent(this.title, this.projectScopeFlag,
      this.numberOfStudents, this.proposalsLessThan);
}

class GetProjectDetail extends GeneralProjectEvent {
  final String id;
  GetProjectDetail({required this.id});
}

class GetFavoriteProject extends GeneralProjectEvent {
  final String studentId;
  GetFavoriteProject({required this.studentId});
}

class AddFavoriteProject extends GeneralProjectEvent {
  final String projectId;
  final String studentId;
  AddFavoriteProject({required this.studentId, required this.projectId});
}

class RemoveFavoriteProject extends GeneralProjectEvent {
  final String projectId;
  final String studentId;
  RemoveFavoriteProject({required this.studentId, required this.projectId});
}

class RemoveFavoriteProjectList extends GeneralProjectEvent {
  final Project project;
  RemoveFavoriteProjectList({required this.project});
}

class GetAllProposalOfProjectEvent extends GeneralProjectEvent {
  final RequestProjectProposal requestProposal;
  final Function? onSuccess;

  GetAllProposalOfProjectEvent({required this.requestProposal, required this.onSuccess});
}

class ResetBlocEvents extends GeneralProjectEvent {
  ResetBlocEvents();
}
