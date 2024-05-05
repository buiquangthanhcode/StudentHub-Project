import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/services/api_interceptor.dart';
import 'package:studenthub/services/dio_client.dart';
import 'package:studenthub/services/endpoint.dart';
import 'package:studenthub/utils/logger.dart';

class CompanyService {
  late DioClient dioClient;

  CompanyService() {
    var dio = Dio();
    AppInterceptors interceptors = AppInterceptors(dio);
    dioClient = DioClient(dio, interceptors: [interceptors]);
  }

  // Future<ResponseAPI<Company>> updateInformation() async {
  //   try {
  //     final res = await dioClient.get(
  //       '$baseURL/api/profile/company',
  //     );
  //     logger.d(res.data);

  //     return ResponseAPI<Company>(
  //         // statusCode: res.statusCode,
  //         // data: Company.fromJson(
  //         //     res.data['result'].map((x) => TechStack.fromMap((x)))),
  //         );
  //   } on DioException catch (e) {
  //     logger.e(
  //       "DioException :${e.response}",
  //     );
  //     throw ResponseAPI<Company>(
  //       statusCode: e.response?.statusCode,
  //       data: Company(),
  //     );
  //   } catch (e) {
  //     logger.e("Unexpected Error: $e");
  //     rethrow;
  //   }
  // }

  Future<ResponseAPI<Project>> postNewProject(Project newProject) async {
    try {
      final res = await dioClient.post(
        '$baseURL/api/project',
        data: newProject.toJson(),
      );
      logger.d(res.data);
      logger.i('successfully!');
      return ResponseAPI<Project>(
        statusCode: res.statusCode,
        data: Project.fromMap(res.data['result']),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<Company>(
        statusCode: e.response?.statusCode,
        data: Company(),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<Company>> addInformation(Company company) async {
    try {
      final res = await dioClient.post(
        '$baseURL/api/profile/company',
        data: company.toJson(),
      );

      return ResponseAPI<Company>(
        statusCode: res.statusCode,
        data: Company.fromMap(res.data['result']),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<Company>(
        statusCode: e.response?.statusCode,
        data: Company(),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<Company>> updateInformation(Company company, int id) async {
    try {
      final res = await dioClient.put(
        '$baseURL/api/profile/company/${id.toString()}',
        data: json.encode({
          "companyName": company.companyName,
          "size": company.size,
          "website": company.website,
          "description": company.description
        }),
      );

      return ResponseAPI<Company>(
        statusCode: res.statusCode,
        data: Company.fromMap(res.data['result']),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<Company>(
        statusCode: e.response?.statusCode,
        data: Company(),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<Company>> getAllInformation(Company company, int id) async {
    try {
      final res = await dioClient.put(
        '$baseURL/api/profile/company/${id.toString()}',
      );

      logger.d('all data: ${res.data['result']}');

      return ResponseAPI<Company>(
        statusCode: res.statusCode,
        data: Company.fromMap(res.data['result']),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<Company>(
        statusCode: e.response?.statusCode,
        data: Company(),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<Project>>> getAllProjects(int companyId) async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/project/company/${companyId.toString()}',
      );

      return ResponseAPI<List<Project>>(
        statusCode: res.statusCode,
        data: res.data['result'].map<Project>((x) => Project.fromMap(x)).toList(),
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

  Future<ResponseAPI> deleteProject(int projectId) async {
    try {
      final res = await dioClient.delete(
        '$baseURL/api/project/$projectId',
      );

      return ResponseAPI(
        statusCode: res.statusCode,
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> editProject(Project project) async {
    try {
      final res = await dioClient.patch(
        '$baseURL/api/project/${project.id}',
        data: project.toJson(),
      );

      return ResponseAPI(
        statusCode: res.statusCode,
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> closeProject(Project project) async {
    try {
      final res = await dioClient.patch(
        '$baseURL/api/project/${project.id}',
        data: project.toJson(),
      );

      return ResponseAPI(
        statusCode: res.statusCode,
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> startWorkingProject(Project project) async {
    try {
      final res = await dioClient.patch(
        '$baseURL/api/project/${project.id}',
        data: project.toJson(),
      );

      return ResponseAPI(
        statusCode: res.statusCode,
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> hireStudentProprosal(HireStudentProprosalEvent data) async {
    try {
      final res = await dioClient.patch(
        '$baseURL/api/proposal/${data.proposalId}',
        data: json.encode({
          "statusFlag": data.statusFlag,
        }),
      );
      return ResponseAPI(
        statusCode: res.statusCode,
        data: res.data,
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }
}
