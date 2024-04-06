import 'dart:async';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';
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

  Future<ResponseAPI<Company>> updateInformation() async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/profile/company',
      );
      logger.d(res.data);

      return ResponseAPI<Company>(
          // statusCode: res.statusCode,
          // data: Company.fromJson(
          //     res.data['result'].map((x) => TechStack.fromMap((x)))),
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
      throw ResponseAPI<Project>(
        statusCode: e.response?.statusCode,
        data: Project(),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }
}
