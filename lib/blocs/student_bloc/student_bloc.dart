import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/blocs/student_bloc/student_state.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/data/dto/student/request_post_resume.dart';
import 'package:studenthub/data/dto/student/request_update_education.dart';
import 'package:studenthub/data/dto/student/request_update_language.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/models/student/student_create_profile/resume_model.dart';
import 'package:studenthub/models/student/student_model.dart';
import 'package:studenthub/services/student/student.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc()
      : super(
          StudentState(
            isChange: false,
            student: Student(),
            submitProjectProposals: const [],
            activeProjectProposals: const [],
            isLoading: false,
          ),
        ) {
    on<AddSkillSetEvent>(_onAllSkillSet);
    on<GetAllSkillSetEvent>(_onGetAllSkillSet);
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
    on<UpdateUIEvent>(_onUpdateUI);
    on<GetAllExperience>(_onGetAllExperience);
    on<UploadResumeEvent>(_onPostResume);
    on<GetResumeEvent>(_onGetResume);
    on<UpdateStudentEvent>(_onUpdateStudent);
    on<ChangePassWordEvent>(_onChangePassWord);
    on<ResetBlocEvent>(_onResetBloc);
    on<SubmitProposal>(_onSubmitProposal);
    on<GetProposal>(_onGetProposal);
    on<GetAllProjectProposal>(_onGetAllProjectProposal);
    on<SubmitTranScript>(_onSubmitTranScript);
    on<GetTranScription>(_onGetTranScription);
    on<RemoveResumeEvent>(_onRemoveResume);
    on<RemoveTranScriptEvent>(_onRemoveTranscript);
  }

  StudentService studentService = StudentService();

  FutureOr<void> _onGetAllExperience(GetAllExperience event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.getAllExperience(event.userId.toString());
      if (response.statusCode! <= 200) {
        emit(state.update(student: state.student.copyWith(experiences: response.data ?? [])));
        if (event.onSuccess != null) {
          event.onSuccess!();
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onUpdateUI(UpdateUIEvent event, Emitter<StudentState> emit) async {
    emit(state.update(isChange: !state.isChange));
  }

  FutureOr<void> _onPostProfileStudent(PostProfileStudent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI response = await studentService.postProfileStudent(event.profileStudent);
      if (response.statusCode! <= 300) {
        event.currentContext?.read<AuthBloc>().add(GetInformationEvent(
            onSuccess: () {}, accessToken: event.token ?? '', currentContext: event.currentContext));
        event.onSuccess!(Student.fromMap(response.data.resultMap.toMap()));

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
      ResponseAPI<Student> response = await studentService.updateProfileStudent(event.profileStudent);
      if (response.statusCode! <= 200) {
        logger.i(response.data?.toMap());

        final currentData = state.student.toMap();
        final newData = response.data!.toMap();
        final student = Student.fromMap({...currentData, ...newData});
        emit(state.update(student: student, isChange: !state.isChange));
        logger.i(response.data?.toMap());
        event.onSuccess!(response.data ?? Student());
      }
    } catch (e) {
      logger.e(e);
    } finally {}
  }

  FutureOr<void> _onGetAllLanguage(GetAllLanguageEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.getAllLanguage(event.userId);
      if (response.statusCode! <= 200) {
        emit(state.update(student: state.student.copyWith(languages: response.data ?? [])));
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
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.getAllSkillSet();
      if (response.statusCode! <= 200) {
        emit(state.update(student: state.student.copyWith(skillSets: response.data ?? [])));
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
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.getAllEducation(event.id);
      if (response.statusCode! <= 200) {
        emit(state.update(student: state.student.copyWith(educations: response.data ?? [])));
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onAllSkillSet(AddSkillSetEvent event, Emitter<StudentState> emit) async {
    // // Clone skill set and then update staet
    // final List<SkillSet> newSkillSet = List<SkillSet>.from(state.skillset);
    // newSkillSet.add(event.skill);
    // emit(state.update(skillset: newSkillSet));
  }

  FutureOr<void> _onRemoveSkillSet(RemoveSkillSetEvent event, Emitter<StudentState> emit) async {
    // // Clone skill set and then update state
    // final List<SkillSet> newSkillSet = List<SkillSet>.from(state.skillset);
    // newSkillSet.remove(event.skill);
    // emit(state.update(skillset: newSkillSet));
  }

  FutureOr<void> _onAddLanguage(AddLanguageEvent event, Emitter<StudentState> emit) async {
    // // Clone skill set and then update state
    // final List<Language> newLanguage = List<Language>.from(state.languages);
    // newLanguage.add(event.language);
    // emit(state.update(languages: newLanguage));
    // event.onSuccess!();
  }

  FutureOr<void> _onRemoveLanguage(RemoveLanguageEvent event, Emitter<StudentState> emit) async {
    // // Clone skill set and then update state
    // final List<Language> newLanguage = List<Language>.from(state.languages);
    // newLanguage.remove(event.language);
    // emit(state.update(languages: newLanguage));
    // event.onSuccess!();
  }

  FutureOr<void> _onUpdateLanguage(UpdateLanguageEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      RequestUpdateLanguage requestUpdateLanguage = RequestUpdateLanguage(
        userid: event.userId,
        languages: event.languages,
      );
      final response = await studentService.updateLanguage(requestUpdateLanguage);
      if (response.statusCode! <= 200) {
        emit(state.update(student: state.student.copyWith(languages: event.languages)));
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();

      logger.e(e);
    }
  }

  FutureOr<void> _onAddEducation(AddEducationEvent event, Emitter<StudentState> emit) async {
    // // Clone skill set and then update state
    // final List<Education> newEducation = List<Education>.from(state.edutcations);
    // newEducation.add(event.education);
    // emit(state.update(edutcations: newEducation));
    // event.onSuccess!();
  }

  FutureOr<void> _onRemoveEducation(RemoveEducationEvent event, Emitter<StudentState> emit) async {
    // // Clone skill set and then update state
    // final List<Education> newEducation = List<Education>.from(state.edutcations);
    // newEducation.remove(event.education);
    // emit(state.update(edutcations: newEducation));
    // event.onSuccess!();
  }

  FutureOr<void> _onUpdateEducation(UpdateEducationEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      RequestUpdateEducation requestUpdateEducation = RequestUpdateEducation(
        userid: event.userId,
        educations: event.educations,
      );
      final response = await studentService.updateEducation(requestUpdateEducation);
      if (response.statusCode! <= 200) {
        emit(state.update(student: state.student.copyWith(educations: event.educations)));
        emit(state.update(isChange: !state.isChange));
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onAddProject(AddProjectEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.updateExperience(event.experience);
      if (response.statusCode! <= 200) {
        emit(state.update(student: state.student.copyWith(experiences: response.data ?? [])));
        emit(state.update(isChange: !state.isChange));
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onUpdateProject(UpdateProjectEvent event, Emitter<StudentState> emit) async {
    // // Clone skill set and then update state
    // final List<ProjectResume> newProject = List<ProjectResume>.from(state.experiences);
    // newProject[newProject.indexWhere((element) => element.id == event.project.id)] = event.project;
    // emit(state.update(experiences: newProject));
    // event.onSuccess!();
  }

  FutureOr<void> _onRemoveProject(RemoveProjectEvents event, Emitter<StudentState> emit) async {
    // // Clone skill set and then update state
    // final List<ProjectResume> newProject = List<ProjectResume>.from(state.experiences);
    // newProject.remove(event.project);
    // emit(state.update(experiences: newProject));
    // event.onSuccess!();
  }

  FutureOr<ResponseAPI<Resume>> _onPostResume(UploadResumeEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      List<MultipartFile> multipartFiles = [];
      multipartFiles.add(
        await MultipartFile.fromFile(
          event.path,
          filename: event.name,
          // contentType: MediaType('image', 'jpg'),
        ),
      );
      RequestPostResume requestUpdateEducation = RequestPostResume(
        studentId: event.userId.toString(),
        file: multipartFiles,
      );
      final response = await studentService.uploadResume(requestUpdateEducation);
      if (response.statusCode! <= 200) {
        event.onSuccess!();
        EasyLoading.dismiss();
      }
      return ResponseAPI<Resume>(
        statusCode: response.statusCode,
        data: Resume.fromMap(response.data['result']),
      );
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
      rethrow;
    }
  }

  FutureOr<void> _onGetResume(GetResumeEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.getResume(event.studentId);
      if (response.statusCode! <= 300) {
        emit(state.update(student: state.student.copyWith(resumeUrl: response.data)));
        if (event.onSuccess != null) {
          event.onSuccess!(response.data ?? '');
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onUpdateStudent(UpdateStudentEvent event, Emitter<StudentState> emit) async {
    emit(state.update(student: event.student));
  }

  FutureOr<void> _onChangePassWord(ChangePassWordEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.changePassWord(event.requestChangePassWordRequest);
      if (response.statusCode! <= 200) {
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onResetBloc(ResetBlocEvent event, Emitter<StudentState> emit) async {
    // I wan to reset student but not id field in the student
    Student newStudent = state.student.reset();
    emit(state.update(
      student: newStudent,
      submitProjectProposals: [],
    ));
  }

  FutureOr<void> _onSubmitProposal(SubmitProposal event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.postProposal(event.requestProposal);
      if (response.statusCode! <= 201) {
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onGetProposal(GetProposal event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.getAllProprosal(event.userId.toString());
      if (response.statusCode! <= 201) {
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onGetAllProjectProposal(GetAllProjectProposal event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      emit(state.update(isLoading: true));
      final response = await studentService.getAllProjectProposal(event);
      List<ProjectProposal> data = response.data ?? [];
      if (response.statusCode! <= 201) {
        sortProjectsByCreatedAt(data);
        if (event.statusFlag != null && event.statusFlag == "0") {
          emit(state.update(submitProjectProposals: data));
        } else {
          List<ProjectProposal> result = [];
          data.forEach((element) {
            if (element.statusFlag == 1) {
              result.add(element);
            }
          });
          emit(state.update(activeProjectProposals: result));
        }
        event.onSuccess!();
        emit(state.update(isLoading: false));

        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<ResponseAPI<Resume>> _onSubmitTranScript(SubmitTranScript event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      List<MultipartFile> multipartFiles = [];
      multipartFiles.add(
        await MultipartFile.fromFile(
          event.path,
          filename: event.name,
          // contentType: MediaType('image', 'jpg'),
        ),
      );
      RequestPostResume requestSubmitProposal = RequestPostResume(
        studentId: event.userId.toString(),
        file: multipartFiles,
      );
      final response = await studentService.uploadTransciption(requestSubmitProposal);
      if (response.statusCode! <= 300) {
        event.onSuccess!();
        EasyLoading.dismiss();
      }
      return ResponseAPI<Resume>(
        statusCode: response.statusCode,
        data: Resume.fromMap(response.data['result']),
      );
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
      rethrow;
    }
  }

  FutureOr<void> _onGetTranScription(GetTranScription event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      final response = await studentService.getTranscript(event.studentId);
      if (response.statusCode! <= 300) {
        emit(state.update(
            student: state.student.copyWith(
          transcriptUrl: response.data,
        )));
        if (event.onSuccess != null) {
          event.onSuccess!(response.data ?? '');
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onRemoveResume(RemoveResumeEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: 'loading');
      final response = await studentService.removeResume(event.studentId.toString());
      if (response.statusCode! <= 300) {
        emit(state.update(student: state.student.copyWith(resumeUrl: '', resume: null)));

        if (event.onSuccess != null) {
          event.onSuccess!();
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onRemoveTranscript(RemoveTranScriptEvent event, Emitter<StudentState> emit) async {
    try {
      EasyLoading.show(status: 'loading');
      final response = await studentService.removeTranScription(event.studentId.toString());
      if (response.statusCode! <= 300) {
        emit(state.update(student: state.student.copyWith(transcriptUrl: '', transcript: null)));
        if (event.onSuccess != null) {
          event.onSuccess!();
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }
}
