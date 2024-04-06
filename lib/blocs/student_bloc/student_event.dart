import 'package:flutter/material.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';

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
  final Language language;
  final Function? onSuccess;

  UpdateLanguageEvent({required this.language, required this.onSuccess});
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
  final Education education;
  final Function? onSuccess;

  UpdateEducationEvent({required this.education, required this.onSuccess});
}

class AddProjectEvent extends StudentEvent {
  final ProjectResume project;
  final Function? onSuccess;

  AddProjectEvent({required this.project, required this.onSuccess});
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
