import 'package:equatable/equatable.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';

class StudentCreateProfileState extends Equatable {
  final List<SkillSet> skillset;
  final List<Language> languages;
  final List<Education> edutcations;
  final List<ProjectResume> projects;
  final bool isChange;
  final List<TechStack> teckstacks;

  const StudentCreateProfileState({
    required this.skillset,
    required this.isChange,
    required this.languages,
    required this.edutcations,
    required this.projects,
    required this.teckstacks,
  });

  @override
  List<Object?> get props => [skillset, isChange, languages, edutcations, projects, teckstacks];

  StudentCreateProfileState update({
    List<SkillSet>? skillset,
    bool? isChange,
    List<Language>? languages,
    List<Education>? edutcations,
    List<ProjectResume>? projects,
    List<TechStack>? teckstacks,
  }) {
    return StudentCreateProfileState(
      skillset: skillset ?? this.skillset,
      isChange: isChange ?? this.isChange,
      languages: languages ?? this.languages,
      edutcations: edutcations ?? this.edutcations,
      projects: projects ?? this.projects,
      teckstacks: teckstacks ?? this.teckstacks,
    );
  }
}
