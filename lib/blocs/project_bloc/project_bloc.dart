import 'dart:async';
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
            project: Project(),
          ),
        ) {
    on<UpdateNewProjectEvent>(_onUpdateNewProject);
    on<PostNewProjectEvent>(_onPostNewProject);
  }

  final CompanyService _companyService = CompanyService();
  final StudentService _studentService = StudentService();

  FutureOr<void> _onUpdateNewProject(
      UpdateNewProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      emit(state.update(project: event.newProject));
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onPostNewProject(
      PostNewProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      final response = await _companyService.postNewProject(event.newProject);
      if (response.statusCode! <= 201) {
        emit(state.update(project: response.data!));
        event.onSuccess!();
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
