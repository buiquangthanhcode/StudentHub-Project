import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_event.dart';
import 'package:studenthub/blocs/general_project_bloc/general_project_state.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/services/all_projects/all_projects.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class GeneralProjectBloc
    extends Bloc<GeneralProjectEvent, GeneralProjectState> {
  GeneralProjectBloc()
      : super(
          GeneralProjectState(
            projectList: const [],
            projectDetail: Project(),
            projectFavorite: const [],
            // ignore: prefer_collection_literals
            projectSearchSuggestions: Set(),
            projectSearchList: const [],
            proposalList: const [],
            proposalHireList: const [],
            isLoading: false,
          ),
        ) {
    on<GetAllDataEvent>(_onGetAllData);
    on<GetProjectDetail>(_onGetProjectDetail);
    on<GetFavoriteProject>(_onGetAllFavoriteProject);
    on<AddFavoriteProject>(_onAddFavoriteProject);
    on<RemoveFavoriteProject>(_onRemoveFavoriteProject);
    on<RemoveFavoriteProjectList>(_onRemoveFavoriteProjectList);
    on<GetSearchFilterDataEvent>(_onGetSearchFilterData);
    on<GetAllSearchTitleEvent>(_onGetAllSearchTitleData);
    on<GetAllProposalOfProjectEvent>(_onGetAllProjectProposalOfProject);
    on<ResetBlocEvents>(_onResetBloc);
  }

  final AllProjectsService _allProjectsService = AllProjectsService();

  FutureOr<void> _onGetAllData(
      GetAllDataEvent event, Emitter<GeneralProjectState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result = await _allProjectsService.getAllProjects(null, null);

      Set<String> projectSearchSuggestions = {};
      for (Project p in result.data) {
        projectSearchSuggestions.add(p.title.toString());
      }

      if (result.statusCode! < 300) {
        emit(state.update(
            projectList: result.data,
            projectSearchSuggestions: projectSearchSuggestions));
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

  FutureOr<void> _onGetAllSearchTitleData(
      GetAllSearchTitleEvent event, Emitter<GeneralProjectState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result = await _allProjectsService.getAllProjects(1, 2000);

      Set<String> projectSearchSuggestions = {};
      for (Project p in result.data) {
        projectSearchSuggestions.add(p.title.toString());
      }

      if (result.statusCode! < 300) {
        emit(state.update(projectSearchSuggestions: projectSearchSuggestions));
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
      GetProjectDetail event, Emitter<GeneralProjectState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
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

  FutureOr<void> _onGetAllFavoriteProject(
      GetFavoriteProject event, Emitter<GeneralProjectState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result =
          await _allProjectsService.getAllFavoriteProject(event.studentId);

      if (result.statusCode! < 300) {
        emit(state.update(projectFavorite: result.data));
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

  FutureOr<void> _onAddFavoriteProject(
      AddFavoriteProject event, Emitter<GeneralProjectState> emit) async {
    try {
      ResponseAPI result = await _allProjectsService.addFavoriteProject(
          event.studentId, event.projectId);

      if (result.statusCode! < 300) {
        final data = state.projectList.map((project) {
          if (project.id == int.parse(event.projectId)) {
            return project.copyWith(isFavorite: true);
          }
          return project;
        }).toList();

        final searchData = state.projectSearchList.map((project) {
          if (project.id == int.parse(event.projectId)) {
            return project.copyWith(isFavorite: true);
          }
          return project;
        }).toList();

        emit(state.update(
            projectList: List<Project>.from(data),
            projectSearchList: List<Project>.from(searchData)));
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

  FutureOr<void> _onRemoveFavoriteProject(
      RemoveFavoriteProject event, Emitter<GeneralProjectState> emit) async {
    try {
      ResponseAPI result = await _allProjectsService.removeFavoriteProject(
          event.studentId, event.projectId);

      if (result.statusCode! < 300) {
        final data = state.projectList.map((project) {
          if (project.id == int.parse(event.projectId)) {
            return project.copyWith(isFavorite: false);
          }
          return project;
        }).toList();
        final searchData = state.projectSearchList.map((project) {
          if (project.id == int.parse(event.projectId)) {
            return project.copyWith(isFavorite: false);
          }
          return project;
        }).toList();

        final favoriteData = state.projectFavorite
            .where((project) => project.id != int.parse(event.projectId))
            .toList();
        // logger.d("REMOVE FAVORITE: \n $data");
        emit(state.update(
            projectList: List<Project>.from(data),
            projectFavorite: List<Project>.from(favoriteData),
            projectSearchList: List<Project>.from(searchData)));
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

  void _onRemoveFavoriteProjectList(
      RemoveFavoriteProjectList event, Emitter<GeneralProjectState> emit) {
    final data = List<Project>.from(state.projectFavorite);
    data.remove(event.project);
    emit(state.update(projectFavorite: List<Project>.from(data)));
  }

  FutureOr<void> _onGetSearchFilterData(
      GetSearchFilterDataEvent event, Emitter<GeneralProjectState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result = await _allProjectsService.getSearchFilterData(
          event.title,
          event.projectScopeFlag,
          event.numberOfStudents,
          event.proposalsLessThan,
          null,
          null);

      logger.d("BLOC: $result");

      if (result.statusCode! < 300 || result.statusCode == 404) {
        emit(state.update(
          projectSearchList: result.data,
        ));
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

  FutureOr<void> _onGetAllProjectProposalOfProject(
      GetAllProposalOfProjectEvent event,
      Emitter<GeneralProjectState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      final response =
          await _allProjectsService.getProposalOfProject(event.requestProposal);
      if (response.statusCode! <= 201) {
        if (event.requestProposal.statusFlag != null &&
            event.requestProposal.statusFlag == 3) {
          emit(state.update(proposalHireList: response.data ?? []));
        } else {
          emit(state.update(proposalList: response.data ?? []));
        }
        event.onSuccess!();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      logger.e(e);
    }
  }

  void _onResetBloc(ResetBlocEvents event, Emitter<GeneralProjectState> emit) {
    emit(state.update(
      projectList: const [],
      projectDetail: Project(),
      projectFavorite: const [],
      projectSearchSuggestions: Set(),
      projectSearchList: const [],
      proposalList: const [],
    ));
  }
}
