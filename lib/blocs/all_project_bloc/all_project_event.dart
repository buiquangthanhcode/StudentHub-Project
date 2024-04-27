import 'package:flutter/material.dart';
import 'package:studenthub/data/dto/student/request_get_proposal_project.dart';
import 'package:studenthub/data/dto/student/request_post_proposal.dart';
import 'package:studenthub/models/common/project_model.dart';

@immutable
abstract class AllProjectEvent {}

class GetAllDataEvent extends AllProjectEvent {
  GetAllDataEvent();
}

class GetSearchFilterDataEvent extends AllProjectEvent {
  final String? title;
  final int? projectScopeFlag;
  final int? numberOfStudents;
  final int? proposalsLessThan;
  GetSearchFilterDataEvent(this.title, this.projectScopeFlag,
      this.numberOfStudents, this.proposalsLessThan);
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

class GetAllProposalOfProjectEvent extends AllProjectEvent {
  final RequestProjectProposal requestProposal;
  final Function? onSuccess;

  GetAllProposalOfProjectEvent({required this.requestProposal, required this.onSuccess});
}

class ResetBlocEvents extends AllProjectEvent {
  ResetBlocEvents();
}
