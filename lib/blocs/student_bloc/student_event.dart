import 'package:flutter/material.dart';
import 'package:studenthub/data/dto/student/request_change_password.dart';
import 'package:studenthub/data/dto/student/request_post_experience.dart';
import 'package:studenthub/data/dto/student/request_post_proposal.dart';
import 'package:studenthub/data/dto/student/request_update_profile_student.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_model.dart';

@immutable
abstract class StudentEvent {}

class GetAllTeckStackEvent extends StudentEvent {
  final Function? onSuccess;
  GetAllTeckStackEvent({this.onSuccess});
}

class GetAllSkillSetEvent extends StudentEvent {
  final Function? onSuccess;
  GetAllSkillSetEvent({this.onSuccess});
}

class GetAllEducationEvent extends StudentEvent {
  final Function? onSuccess;
  final int id;
  GetAllEducationEvent({this.onSuccess, required this.id});
}

class AddSkillSetEvent extends StudentEvent {
  final SkillSet skill;

  AddSkillSetEvent(this.skill);
}

class RemoveSkillSetEvent extends StudentEvent {
  final SkillSet skill;

  RemoveSkillSetEvent(this.skill);
}

class AddLanguageEvent extends StudentEvent {
  final Language language;
  final Function? onSuccess;

  AddLanguageEvent({required this.language, this.onSuccess});
}

class RemoveLanguageEvent extends StudentEvent {
  final Language language;
  final Function? onSuccess;

  RemoveLanguageEvent({required this.language, this.onSuccess});
}

class UpdateLanguageEvent extends StudentEvent {
  final List<Language> languages;
  final int userId;
  final Function? onSuccess;

  UpdateLanguageEvent({required this.languages, required this.onSuccess, required this.userId});
}

class GetAllLanguageEvent extends StudentEvent {
  final int userId;
  final Function? onSuccess;

  GetAllLanguageEvent({required this.onSuccess, required this.userId});
}

class AddEducationEvent extends StudentEvent {
  final Education education;
  final Function? onSuccess;

  AddEducationEvent({required this.education, required this.onSuccess});
}

class RemoveEducationEvent extends StudentEvent {
  final Education education;
  final Function? onSuccess;

  RemoveEducationEvent({required this.education, required this.onSuccess});
}

class UpdateEducationEvent extends StudentEvent {
  final List<Education> educations;
  final int userId;
  final Function? onSuccess;

  UpdateEducationEvent({required this.educations, required this.onSuccess, required this.userId});
}

class PostProfileStudent extends StudentEvent {
  final RequestUpdateProfileStudent profileStudent;
  final BuildContext? currentContext;
  final Function(Student student)? onSuccess;
  final String? token;

  PostProfileStudent({required this.profileStudent, required this.onSuccess, this.currentContext, this.token});
}

class UpdateProfileStudent extends StudentEvent {
  final RequestUpdateProfileStudent profileStudent;
  final Function(Student student)? onSuccess;

  UpdateProfileStudent({required this.profileStudent, required this.onSuccess});
}

class AddProjectEvent extends StudentEvent {
  final RequestPostExperience experience;
  final Function? onSuccess;

  AddProjectEvent({required this.experience, required this.onSuccess});
}

class UpdateProjectEvent extends StudentEvent {
  final ProjectResume project;
  final Function? onSuccess;

  UpdateProjectEvent({required this.project, required this.onSuccess});
}

class RemoveProjectEvents extends StudentEvent {
  final ProjectResume project;
  final Function? onSuccess;

  RemoveProjectEvents({required this.project, required this.onSuccess});
}

class UpdateUIEvent extends StudentEvent {
  UpdateUIEvent();
}

class GetAllExperience extends StudentEvent {
  final int userId;
  final Function? onSuccess;

  GetAllExperience({required this.userId, this.onSuccess});
}

class UploadResumeEvent extends StudentEvent {
  final String path;
  final int userId;
  final String name;
  final Function? onSuccess;

  UploadResumeEvent({required this.path, required this.userId, this.onSuccess, required this.name});
}

class GetResumeEvent extends StudentEvent {
  final String studentId;
  final Function()? onSuccess;

  GetResumeEvent({required this.studentId, this.onSuccess});
}

class UpdateStudentEvent extends StudentEvent {
  final Student student;
  final bool isChange;

  UpdateStudentEvent({required this.student, required this.isChange});
}

class ChangePassWordEvent extends StudentEvent {
  final RequestChangePassWord requestChangePassWordRequest;
  final Function? onSuccess;

  ChangePassWordEvent({required this.requestChangePassWordRequest, required this.onSuccess});
}

class ResetBlocEvent extends StudentEvent {
  ResetBlocEvent();
}

class SubmitProposal extends StudentEvent {
  final RequestProposal requestProposal;
  final Function? onSuccess;

  SubmitProposal({required this.requestProposal, required this.onSuccess});
}

class GetProposal extends StudentEvent {
  final int userId;
  final Function? onSuccess;

  GetProposal({required this.userId, required this.onSuccess});
}

class GetAllProjectProposal extends StudentEvent {
  final int userId;
  final String? statusFlag;
  final Function? onSuccess;

  GetAllProjectProposal({required this.userId, required this.onSuccess, this.statusFlag});
}

class SubmitTranScript extends StudentEvent {
  final String path;
  final int userId;
  final String name;
  final Function? onSuccess;

  SubmitTranScript({required this.path, required this.userId, required this.name, required this.onSuccess});
}

class GetTranScription extends StudentEvent {
  final String studentId;
  final Function()? onSuccess;

  GetTranScription({required this.studentId, this.onSuccess});
}
