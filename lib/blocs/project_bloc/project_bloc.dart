import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/blocs/company_bloc/company_state.dart';
import 'package:studenthub/blocs/project_bloc/project_event.dart';
import 'package:studenthub/blocs/project_bloc/project_state.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/services/company/company.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/services/student/student.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc()
      : super(
          ProjectState(
            allProjects: [],
            workingProjects: [],
            archivedProjects: [],
            projectCreation: Project(),
          ),
        ) {
    on<GetAllProjectsEvent>(_onGetAllProjects);
    on<GetWorkingProjectsEvent>(_onGetWorkingProjects);
    on<GetArchivedProjectsEvent>(_onGetArchivedProjects);
    on<UpdateNewProjectEvent>(_onUpdateNewProject);
    on<PostNewProjectEvent>(_onPostNewProject);
    on<DeleteProjectEvent>(_onDeleteProject);
    on<EditProjectEvent>(_onEditProject);
    on<CloseProjectEvent>(_onCloseProject);
    on<StartWorkingProjectEvent>(_onStartWorkingProject);
  }

  final CompanyService _companyService = CompanyService();
  final StudentService _studentService = StudentService();

  Future<void> _onGetAllProjects(
      GetAllProjectsEvent event, Emitter<ProjectState> emit) async {
    try {
      final response = await _companyService.getAllProjects(event.companyId);
      if (response.statusCode! <= 201) {
        emit(state.update(allProjects: response.data!.toList()));
      }
    } catch (e) {
      logger.e(e);
    }
  }

  void _onGetWorkingProjects(
      GetWorkingProjectsEvent event, Emitter<ProjectState> emit) async {
    try {
      // Add your code here
      final workingProjects =
          state.allProjects.where((element) => element.typeFlag == 0).toList();
      emit(state.update(workingProjects: workingProjects));
    } catch (e) {
      logger.e(e);
    }
  }

  void _onGetArchivedProjects(
      GetArchivedProjectsEvent event, Emitter<ProjectState> emit) async {
    try {
      // Add your code here
      final archivedProjects =
          state.allProjects.where((element) => element.typeFlag == 1).toList();
      emit(state.update(archivedProjects: archivedProjects));
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onUpdateNewProject(
      UpdateNewProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      emit(state.update(projectCreation: event.newProject));
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onPostNewProject(
      PostNewProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      final response = await _companyService.postNewProject(event.newProject);
      if (response.statusCode! <= 201) {
        // Do khi push lại vào trang home từ trang post project sẽ gọi event GetAllProjectsEvent để rerender
        event.onSuccess!();
      }
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onDeleteProject(
      DeleteProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      final response = await _companyService.deleteProject(event.projectId);
      if (response.statusCode! <= 201) {
        add(GetAllProjectsEvent(companyId: event.companyId));
        event.onSuccess!();
      }
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onEditProject(
      EditProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      final response = await _companyService.editProject(event.updatedProject);
      if (response.statusCode! <= 201) {
        add(GetAllProjectsEvent(companyId: event.companyId));
        event.onSuccess!();
      }
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onCloseProject(
      CloseProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      final response = await _companyService.closeProject(event.updatedProject);
      if (response.statusCode! <= 201) {
        add(GetAllProjectsEvent(companyId: event.companyId));
        event.onSuccess!();
      }
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onStartWorkingProject(
      StartWorkingProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      final response =
          await _companyService.startWorkingProject(event.updatedProject);
      if (response.statusCode! <= 201) {
        add(GetAllProjectsEvent(companyId: event.companyId));
        event.onSuccess!();
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
