import 'package:flutter/material.dart';
import 'package:studenthub/models/student_create_profile/education_model.dart';
import 'package:studenthub/models/student_create_profile/language_model.dart';
import 'package:studenthub/models/student_create_profile/project_model.dart';
import 'package:studenthub/models/student_create_profile/skillset_model.dart';

@immutable
abstract class StudentCreateProfileEvent {}

class AddSkillSetEvent extends StudentCreateProfileEvent {
  final SkillSet skill;

  AddSkillSetEvent(this.skill);
}

class RemoveSkillSetEvent extends StudentCreateProfileEvent {
  final SkillSet skill;

  RemoveSkillSetEvent(this.skill);
}

class AddLanguageEvent extends StudentCreateProfileEvent {
  final Language language;
  final Function? onSuccess;

  AddLanguageEvent({required this.language, this.onSuccess});
}

class RemoveLanguageEvent extends StudentCreateProfileEvent {
  final Language language;
  final Function? onSuccess;

  RemoveLanguageEvent({required this.language, this.onSuccess});
}

class UpdateLanguageEvent extends StudentCreateProfileEvent {
  final Language language;

  UpdateLanguageEvent(this.language);
}

class AddEducationEvent extends StudentCreateProfileEvent {
  final Education education;

  AddEducationEvent(this.education);
}

class RemoveEducationEvent extends StudentCreateProfileEvent {
  final Education education;

  RemoveEducationEvent(this.education);
}

class UpdateEducationEvent extends StudentCreateProfileEvent {
  final Education education;

  UpdateEducationEvent(this.education);
}

class AddProjectEvent extends StudentCreateProfileEvent {
  final Project project;
  final Function? onSuccess;

  AddProjectEvent({required this.project, required this.onSuccess});
}

class UpdateProjectEvent extends StudentCreateProfileEvent {
  final Project project;
  final Function? onSuccess;

  UpdateProjectEvent({required this.project, required this.onSuccess});
}

class RemoveProjectEvents extends StudentCreateProfileEvent {
  final Project project;
  final Function? onSuccess;

  RemoveProjectEvents({required this.project, required this.onSuccess});
}
