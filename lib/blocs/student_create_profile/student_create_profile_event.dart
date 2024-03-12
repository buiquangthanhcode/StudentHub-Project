import 'package:flutter/material.dart';
import 'package:studenthub/models/student_create_profile/education_model.dart';
import 'package:studenthub/models/student_create_profile/language_model.dart';
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

  AddLanguageEvent(this.language);
}

class RemoveLanguageEvent extends StudentCreateProfileEvent {
  final Language language;

  RemoveLanguageEvent(this.language);
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
