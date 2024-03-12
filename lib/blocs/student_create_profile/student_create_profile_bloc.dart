import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_state.dart';
import 'package:studenthub/models/student_create_profile/education_model.dart';
import 'package:studenthub/models/student_create_profile/language_model.dart';
import 'package:studenthub/models/student_create_profile/skillset_model.dart';

class StudentCreateProfileBloc extends Bloc<StudentCreateProfileEvent, StudentCreateProfileState> {
  StudentCreateProfileBloc()
      : super(
          const StudentCreateProfileState(
            skillset: [],
            isChange: false,
            languages: [],
            edutcations: [],
          ),
        ) {
    on<AddSkillSetEvent>(_onAllSkillSet);
    on<RemoveSkillSetEvent>(_onRemoveSkillSet);
    on<AddLanguageEvent>(_onAddLanguage);
    on<RemoveLanguageEvent>(_onRemoveLanguage);
    on<UpdateLanguageEvent>(_onUpdateLanguage);
    on<AddEducationEvent>(_onAddEducation);
    on<RemoveEducationEvent>(_onRemoveEducation);
    on<UpdateEducationEvent>(_onUpdateEducation);
  }

  FutureOr<void> _onAllSkillSet(AddSkillSetEvent event, Emitter<StudentCreateProfileState> emit) async {
    // Clone skill set and then update staet
    final List<SkillSet> newSkillSet = List<SkillSet>.from(state.skillset);
    newSkillSet.add(event.skill);
    emit(state.update(skillset: newSkillSet));
  }

  FutureOr<void> _onRemoveSkillSet(RemoveSkillSetEvent event, Emitter<StudentCreateProfileState> emit) async {
    // Clone skill set and then update state
    final List<SkillSet> newSkillSet = List<SkillSet>.from(state.skillset);
    newSkillSet.remove(event.skill);
    emit(state.update(skillset: newSkillSet));
  }

  FutureOr<void> _onAddLanguage(AddLanguageEvent event, Emitter<StudentCreateProfileState> emit) async {
    // Clone skill set and then update state
    final List<Language> newLanguage = List<Language>.from(state.languages);
    newLanguage.add(event.language);
    emit(state.update(languages: newLanguage));
  }

  FutureOr<void> _onRemoveLanguage(RemoveLanguageEvent event, Emitter<StudentCreateProfileState> emit) async {
    // Clone skill set and then update state
    final List<Language> newLanguage = List<Language>.from(state.languages);
    newLanguage.remove(event.language);
    emit(state.update(languages: newLanguage));
  }

  FutureOr<void> _onUpdateLanguage(UpdateLanguageEvent event, Emitter<StudentCreateProfileState> emit) async {
    // Clone skill set and then update state
    final List<Language> newLanguage = List<Language>.from(state.languages);
    newLanguage[newLanguage.indexWhere((element) => element.name == event.language.name)] = event.language;
    emit(state.update(languages: newLanguage));
  }

  FutureOr<void> _onAddEducation(AddEducationEvent event, Emitter<StudentCreateProfileState> emit) async {
    // Clone skill set and then update state
    final List<Education> newEducation = List<Education>.from(state.edutcations);
    newEducation.add(event.education);
    emit(state.update(edutcations: newEducation));
  }

  FutureOr<void> _onRemoveEducation(RemoveEducationEvent event, Emitter<StudentCreateProfileState> emit) async {
    // Clone skill set and then update state
    final List<Education> newEducation = List<Education>.from(state.edutcations);
    newEducation.remove(event.education);
    emit(state.update(edutcations: newEducation));
  }

  FutureOr<void> _onUpdateEducation(UpdateEducationEvent event, Emitter<StudentCreateProfileState> emit) async {
    // Clone skill set and then update state
    final List<Education> newEducation = List<Education>.from(state.edutcations);
    newEducation[newEducation.indexWhere((element) => element.nameOfSchool == event.education.nameOfSchool)] =
        event.education;
    emit(state.update(edutcations: newEducation));
  }
}
