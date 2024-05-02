import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/data/dto/student/request_get_proposal_project.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/models/common/proposal_modal.dart';
import 'package:studenthub/services/api_interceptor.dart';
import 'package:studenthub/services/dio_client.dart';
import 'package:studenthub/services/endpoint.dart';
import 'package:studenthub/utils/logger.dart';

class AllProjectsService {
  late DioClient dioClient;

  AllProjectsService() {
    var dio = Dio();
    AppInterceptors interceptors = AppInterceptors(dio);
    dioClient = DioClient(dio, interceptors: [interceptors]);
  }

  Future<ResponseAPI<List<Project>>> getAllProjects() async {
    try {
      final res = await dioClient.get('$baseURL/api/project');

      return ResponseAPI<List<Project>>(
        statusCode: res.statusCode,
        data:
            res.data['result'].map<Project>((x) => Project.fromMap(x)).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Project>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<Project>> getProjectDetail(String id) async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/project/$id',
      );

      return ResponseAPI<Project>(
        statusCode: res.statusCode,
        data: Project.fromMap(res.data['result']),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Project>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<Project>>> getAllFavoriteProject(
      String studentId) async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/favoriteProject/$studentId',
      );

      return ResponseAPI<List<Project>>(
        statusCode: res.statusCode,
        data: res.data['result']
            .map<Project>((x) => Project.fromMap(x['project']))
            .toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Project>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<dynamic>> addFavoriteProject(
      String studentId, String projectId) async {
    try {
      final res = await dioClient.patch(
        '$baseURL/api/favoriteProject/$studentId',
        data: json.encode({
          "projectId": projectId,
          "disableFlag": 0,
        }),
      );

      return ResponseAPI<dynamic>(
        statusCode: res.statusCode,
        data: res,
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Project>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<dynamic>> removeFavoriteProject(
      String studentId, String projectId) async {
    try {
      final res = await dioClient.patch(
        '$baseURL/api/favoriteProject/$studentId',
        data: json.encode({
          "projectId": projectId,
          "disableFlag": 1,
        }),
      );

      return ResponseAPI<dynamic>(
        statusCode: res.statusCode,
        data: res,
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Project>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<Project>>> getSearchFilterData(
    String? title,
    int? projectScopeFlag,
    int? numberOfStudents,
    int? proposalsLessThan,
  ) async {
    try {
      Map<String, dynamic> query = {};

      if (title != null) {
        query.addAll({'title': title});
      }
      if (projectScopeFlag != null) {
        query.addAll({"projectScopeFlag": projectScopeFlag});
      }
      if (numberOfStudents != null) {
        query.addAll({"numberOfStudents": numberOfStudents});
      }
      if (proposalsLessThan != null) {
        // query.addAll({"proposalsLessThan": proposalsLessThan});
      }

      logger.d('QUERY: $query');

      final res =
          await dioClient.get('$baseURL/api/project', queryParameters: query);

      logger.d('RES: $res');
      if (res.statusCode == 404) {
        logger.d("vao day");
        return ResponseAPI<List<Project>>(
          statusCode: res.statusCode,
          data: [],
        );
      }

      return ResponseAPI<List<Project>>(
        statusCode: res.statusCode,
        data:
            res.data['result'].map<Project>((x) => Project.fromMap(x)).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Project>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<ProjectProposal>>> getProposalOfProject(
      RequestProjectProposal request) async {
    try {
      String url = '$baseURL/api/proposal/getByProjectId/${request.projectId}';
      if (request.statusFlag != null) {
        url += '/?statusFlag=${request.statusFlag}';
      }
      final res = await dioClient.get(url);
      logger.d(res);
      // List of Proposal
      return ResponseAPI<List<ProjectProposal>>(
        statusCode: res.statusCode,
        data: List<ProjectProposal>.from(res.data['result']['items']
            .map((x) => ProjectProposal.fromMap((x)))
            .toList()),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }
}
