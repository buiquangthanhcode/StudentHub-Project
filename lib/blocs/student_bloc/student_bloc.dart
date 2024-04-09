import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/blocs/student_bloc/student_state.dart';
import 'package:studenthub/data/dto/student/request_update_education.dart';
import 'package:studenthub/data/dto/student/request_update_language.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/services/student/student.dart';
import 'package:studenthub/utils/logger.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc()
      : super(
          const StudentState(
            skillset: [],
            isChange: false,
            languages: [],
            edutcations: [],
            projects: [],
            teckstacks: [],
          ),
        ) {
    on<AddSkillSetEvent>(_onAllSkillSet);
    on<GetAllSkillSetEvent>(_onGetAllSkillSet);
    on<GetAllTeckStackEvent>(_onGetAllTeckStack);
    on<RemoveSkillSetEvent>(_onRemoveSkillSet);
    on<AddLanguageEvent>(_onAddLanguage);
    on<GetAllLanguageEvent>(_onGetAllLanguage);
    on<GetAllEducationEvent>(_onGetAllEducation);
    on<RemoveLanguageEvent>(_onRemoveLanguage);
    on<UpdateLanguageEvent>(_onUpdateLanguage);
    on<AddEducationEvent>(_onAddEducation);
    on<RemoveEducationEvent>(_onRemoveEducation);
    on<UpdateEducationEvent>(_onUpdateEducation);
    on<AddProjectEvent>(_onAddProject);
    on<UpdateProjectEvent>(_onUpdateProject);
    on<RemoveProjectEvents>(_onRemoveProject);
    on<PostProfileStudent>(_onPostProfileStudent);
    on<UpdateProfileStudent>(_onUpdateProfileStudent);
  }

  StudentService studentService = StudentService();

  FutureOr<void> _onGetAllTeckStack(GetAllTeckStackEvent event, Emitter<StudentState> emit) async {
    final response = await studentService.getAllTechStack();
    if (response.statusCode! <= 200) {
      emit(state.update(teckstacks: response.data ?? []));
      event.onSuccess!();
    }
  }

  FutureOr<void> _onPostProfileStudent(PostProfileStudent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: 'loading');
      final response = await studentService.postProfileStudent(event.profileStudent);
      if (response.statusCode! <= 200) {
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  FutureOr<void> _onUpdateProfileStudent(UpdateProfileStudent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: 'loading');
      final response = await studentService.updateProfileStudent(event.profileStudent);
      if (response.statusCode! <= 200) {
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  FutureOr<void> _onGetAllLanguage(GetAllLanguageEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: 'loading');
      final response = await studentService.getAllLanguage(event.userId);
      if (response.statusCode! <= 200) {
        emit(state.update(languages: response.data ?? []));
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onGetAllSkillSet(GetAllSkillSetEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: 'loading');
      final response = await studentService.getAllSkillSet();
      if (response.statusCode! <= 200) {
        emit(state.update(skillset: response.data ?? []));
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onGetAllEducation(GetAllEducationEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: 'loading');
      final response = await studentService.getAllEducation(event.id);
      if (response.statusCode! <= 200) {
        emit(state.update(edutcations: response.data ?? []));
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onAllSkillSet(AddSkillSetEvent event, Emitter<StudentState> emit) async {
    // Clone skill set and then update staet
    final List<SkillSet> newSkillSet = List<SkillSet>.from(state.skillset);
    newSkillSet.add(event.skill);
    emit(state.update(skillset: newSkillSet));
  }

  FutureOr<void> _onRemoveSkillSet(RemoveSkillSetEvent event, Emitter<StudentState> emit) async {
    // Clone skill set and then update state
    final List<SkillSet> newSkillSet = List<SkillSet>.from(state.skillset);
    newSkillSet.remove(event.skill);
    emit(state.update(skillset: newSkillSet));
  }

  FutureOr<void> _onAddLanguage(AddLanguageEvent event, Emitter<StudentState> emit) async {
    // Clone skill set and then update state
    final List<Language> newLanguage = List<Language>.from(state.languages);
    newLanguage.add(event.language);
    emit(state.update(languages: newLanguage));
    event.onSuccess!();
  }

  FutureOr<void> _onRemoveLanguage(RemoveLanguageEvent event, Emitter<StudentState> emit) async {
    // Clone skill set and then update state
    final List<Language> newLanguage = List<Language>.from(state.languages);
    newLanguage.remove(event.language);
    emit(state.update(languages: newLanguage));
    event.onSuccess!();
  }

  FutureOr<void> _onUpdateLanguage(UpdateLanguageEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: 'loading');
      RequestUpdateLanguage requestUpdateLanguage = RequestUpdateLanguage(
        userid: event.userId,
        languages: event.languages,
      );
      final response = await studentService.updateLanguage(requestUpdateLanguage);
      if (response.statusCode! <= 200) {
        // emit(state.update(languages: event.languages));
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();

      logger.e(e);
    }
  }

  FutureOr<void> _onAddEducation(AddEducationEvent event, Emitter<StudentState> emit) async {
    // Clone skill set and then update state
    final List<Education> newEducation = List<Education>.from(state.edutcations);
    newEducation.add(event.education);
    emit(state.update(edutcations: newEducation));
    event.onSuccess!();
  }

  FutureOr<void> _onRemoveEducation(RemoveEducationEvent event, Emitter<StudentState> emit) async {
    // Clone skill set and then update state
    final List<Education> newEducation = List<Education>.from(state.edutcations);
    newEducation.remove(event.education);
    emit(state.update(edutcations: newEducation));
    event.onSuccess!();
  }

  FutureOr<void> _onUpdateEducation(UpdateEducationEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: 'Loading');
      RequestUpdateEducation requestUpdateEducation = RequestUpdateEducation(
        userid: event.userId,
        educations: event.educations,
      );
      final response = await studentService.updateEducation(requestUpdateEducation);
      if (response.statusCode! <= 200) {
        emit(state.update(edutcations: event.educations));
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onAddProject(AddProjectEvent event, Emitter<StudentState> emit) async {
    // Clone skill set and then update state
    final List<ProjectResume> newProject = List<ProjectResume>.from(state.projects);
    newProject.add(event.project);
    emit(state.update(projects: newProject));
    event.onSuccess!();
  }

  FutureOr<void> _onUpdateProject(UpdateProjectEvent event, Emitter<StudentState> emit) async {
    // Clone skill set and then update state
    final List<ProjectResume> newProject = List<ProjectResume>.from(state.projects);
    newProject[newProject.indexWhere((element) => element.id == event.project.id)] = event.project;
    emit(state.update(projects: newProject));
    event.onSuccess!();
  }

  FutureOr<void> _onRemoveProject(RemoveProjectEvents event, Emitter<StudentState> emit) async {
    // Clone skill set and then update state
    final List<ProjectResume> newProject = List<ProjectResume>.from(state.projects);
    newProject.remove(event.project);
    emit(state.update(projects: newProject));
    event.onSuccess!();
  }
}
