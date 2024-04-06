import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/blocs/company_bloc/company_state.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/services/company/company.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc()
      : super(
          CompanyState(
            company: Company(),
            project: Project(),
          ),
        ) {
    on<AddAllDataEvent>(_onAddAllData);
    on<UpdateAllDataEvent>(_onUpdateAllData);
    on<GetAllDataEvent>(_onGetAllData);
    on<UpdateNewProjectEvent>(_onUpdateNewProject);
    on<PostNewProjectEvent>(_onPostNewProject);
  }

  final CompanyService _companyService = CompanyService();

  FutureOr<void> _onAddAllData(
      AddAllDataEvent event, Emitter<CompanyState> emit) async {
    try {
      ResponseAPI result = await _companyService.addInformation(event.data);
      if (result.statusCode! < 300) {
        event.onSuccess!(result.data);
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

  FutureOr<void> _onUpdateAllData(
      UpdateAllDataEvent event, Emitter<CompanyState> emit) async {
    try {
      ResponseAPI result =
          await _companyService.updateInformation(event.data, event.id);

      if (result.statusCode! < 300) {
        event.onSuccess!(result.data);
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

  FutureOr<void> _onGetAllData(
      GetAllDataEvent event, Emitter<CompanyState> emit) async {
    try {
      EasyLoading.show(status: 'Loading...');
      ResponseAPI result =
          await _companyService.getAllInformation(event.data, event.id);

      if (result.statusCode! < 300) {
        event.onSuccess!();
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

  FutureOr<void> _onUpdateNewProject(
      UpdateNewProjectEvent event, Emitter<CompanyState> emit) async {
    try {
      emit(state.update(project: event.newProject));
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onPostNewProject(
      PostNewProjectEvent event, Emitter<CompanyState> emit) async {
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
