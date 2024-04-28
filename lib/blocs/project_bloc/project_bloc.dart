import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/project_bloc/project_event.dart';
import 'package:studenthub/blocs/project_bloc/project_state.dart';
import 'package:studenthub/services/company/company.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/utils/logger.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc()
      : super(
          ProjectState(
            allProjects: const [],
            workingProjects: const [],
            archivedProjects: const [],
            projectCreation: Project(),
            isLoading: false,
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

  Future<void> _onGetAllProjects(GetAllProjectsEvent event, Emitter<ProjectState> emit) async {
    try {
      emit(state.update(isLoading: true));
      final response = await _companyService.getAllProjects(event.companyId);
      if (response.statusCode! <= 201) {
        emit(state.update(allProjects: List<Project>.from(response.data!.toList())));
        add(GetWorkingProjectsEvent());
        add(GetArchivedProjectsEvent());
        emit(state.update(isLoading: false));
      }
    } catch (e) {
      logger.e(e);
    }
  }

  void _onGetWorkingProjects(GetWorkingProjectsEvent event, Emitter<ProjectState> emit) async {
    try {
      final workingProjects = state.allProjects.where((element) => element.typeFlag == 1).toList();
      emit(state.update(workingProjects: workingProjects));
    } catch (e) {
      logger.e(e);
    }
  }

  void _onGetArchivedProjects(GetArchivedProjectsEvent event, Emitter<ProjectState> emit) async {
    try {
      final archivedProjects = state.allProjects.where((element) => element.typeFlag == 2).toList();
      emit(state.update(archivedProjects: archivedProjects));
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onUpdateNewProject(UpdateNewProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      emit(state.update(projectCreation: event.newProject));
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onPostNewProject(PostNewProjectEvent event, Emitter<ProjectState> emit) async {
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

  FutureOr<void> _onDeleteProject(DeleteProjectEvent event, Emitter<ProjectState> emit) async {
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

  FutureOr<void> _onEditProject(EditProjectEvent event, Emitter<ProjectState> emit) async {
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

  FutureOr<void> _onCloseProject(CloseProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      EasyLoading.show(status: 'loading');

      final response = await _companyService.closeProject(event.updatedProject);
      if (response.statusCode! <= 201) {
        add(GetAllProjectsEvent(companyId: event.companyId));
        event.onSuccess!();
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  FutureOr<void> _onStartWorkingProject(StartWorkingProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      EasyLoading.show(status: 'loading');

      final response = await _companyService.startWorkingProject(event.updatedProject);
      if (response.statusCode! <= 201) {
        add(GetAllProjectsEvent(companyId: event.companyId));
        event.onSuccess!();
      }
      EasyLoading.dismiss();
    } catch (e) {
      logger.e(e);
    }
  }
}
