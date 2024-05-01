import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';
import 'package:studenthub/services/api_interceptor.dart';
import 'package:studenthub/services/dio_client.dart';
import 'package:studenthub/services/endpoint.dart';
import 'package:studenthub/utils/logger.dart';

class GlobalService {
  late DioClient dioClient;

  GlobalService() {
    var dio = Dio();
    AppInterceptors interceptors = AppInterceptors(dio);
    dioClient = DioClient(dio, interceptors: [interceptors]);
  }

  Future<ResponseAPI<List<TechStack>>> getAllTechStack() async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/techstack/getAllTechStack',
      );

      return ResponseAPI<List<TechStack>>(
        statusCode: res.statusCode,
        data: List<TechStack>.from(
            res.data['result'].map((x) => TechStack.fromMap((x)))).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<TechStack>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<SkillSet>>> getAllSkillSet() async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/skillset/getAllSkillSet',
      );

      return ResponseAPI<List<SkillSet>>(
        statusCode: res.statusCode,
        data: List<SkillSet>.from(
            res.data['result'].map((x) => SkillSet.fromMap((x)))).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<SkillSet>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> resetPassword(String email) async {
    try {
      logger.d("Resetting password: $email");
      final res = await dioClient.post('$baseURL/api/user/forgotPassword',
          data: json.encode({
            "email": email,
          }));

      logger.d("res in reset password: $res");
      return ResponseAPI(statusCode: res.statusCode, data: res.data);
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }
}
