import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/all_project_bloc/all_project_event.dart';
import 'package:studenthub/blocs/all_project_bloc/all_project_state.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/services/all_projects/all_projects.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class AllProjectBloc extends Bloc<AllProjectEvent, AllProjectState> {
  AllProjectBloc()
      : super(
          AllProjectState(
            projectList: const [],
            projectDetail: Project(),
          ),
        ) {
    on<GetAllDataEvent>(_onGetAllData);
    on<GetProjectDetail>(_onGetProjectDetail);
  }

  final AllProjectsService _allProjectsService = AllProjectsService();

  FutureOr<void> _onGetAllData(
      GetAllDataEvent event, Emitter<AllProjectState> emit) async {
    try {
      EasyLoading.show(status: 'Loading...');
      ResponseAPI result = await _allProjectsService.getAllProjects();

      logger.d(result.data);

      if (result.statusCode! < 300) {
        emit(AllProjectState(
            projectList: result.data, projectDetail: Project()));
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails),
            status: StatusSnackBar.error);
      }
    } on DioException catch (e) {
      logger.e(
        "DioException:${e.response}",
      );
    } catch (e) {
      logger.e("Unexpect error-> $e");
      SnackBarService.showSnackBar(
          content: handleFormatMessage(e.toString()),
          status: StatusSnackBar.error);
    } finally {
      EasyLoading.dismiss();
    }
  }

  FutureOr<void> _onGetProjectDetail(
      GetProjectDetail event, Emitter<AllProjectState> emit) async {
    try {
      EasyLoading.show(status: 'Loading...');
      ResponseAPI result = await _allProjectsService.getProjectDetail(event.id);

      if (result.statusCode! < 300) {
        emit(state.update(projectDetail: result.data));
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails),
            status: StatusSnackBar.error);
      }
    } on DioException catch (e) {
      logger.e(
        "DioException:${e.response}",
      );
    } catch (e) {
      logger.e("Unexpect error-> $e");
      SnackBarService.showSnackBar(
          content: handleFormatMessage(e.toString()),
          status: StatusSnackBar.error);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
