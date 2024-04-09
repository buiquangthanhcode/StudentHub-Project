import 'dart:async';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/data/dto/student/request_update_education.dart';
import 'package:studenthub/data/dto/student/request_update_language.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';
import 'package:studenthub/services/api_interceptor.dart';
import 'package:studenthub/services/dio_client.dart';
import 'package:studenthub/services/endpoint.dart';
import 'package:studenthub/utils/logger.dart';

class StudentService {
  late DioClient dioClient;

  StudentService() {
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
        data: List<TechStack>.from(res.data['result'].map((x) => TechStack.fromMap((x)))).toList(),
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
        data: List<SkillSet>.from(res.data['result'].map((x) => SkillSet.fromMap((x)))).toList(),
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

  Future<ResponseAPI> updateLanguage(RequestUpdateLanguage requestUpdateLanguage) async {
    try {
      final res = await dioClient.put(
        '$baseURL/api/language/updateByStudentId/${requestUpdateLanguage.userid}',
        data: requestUpdateLanguage.toJson(),
      );

      logger.d(res);

      return ResponseAPI(
        statusCode: res.statusCode,
        data: [],
      );
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

  Future<ResponseAPI<List<Language>>> getAllLanguage(int userid) async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/language/getByStudentId/$userid',
      );
      return ResponseAPI<List<Language>>(
        statusCode: res.statusCode,
        data: List<Language>.from(res.data['result'].map((x) => Language.fromMap((x)))).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Language>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<Education>>> getAllEducation(int userid) async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/education/getByStudentId/$userid',
      );
      return ResponseAPI<List<Education>>(
        statusCode: res.statusCode,
        data: List<Education>.from(res.data['result'].map((x) => Education.fromMap((x)))).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Education>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> updateEducation(RequestUpdateEducation requestUpdateEducation) async {
    try {
      final res = await dioClient.put(
        '$baseURL/api/education/updateByStudentId/${requestUpdateEducation.userid}',
        data: requestUpdateEducation.toJson(),
      );

      logger.d(res);

      return ResponseAPI(
        statusCode: res.statusCode,
        data: [],
      );
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
