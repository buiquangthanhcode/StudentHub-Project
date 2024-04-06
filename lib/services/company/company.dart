import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/data/dto/reponse.dart';
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

  Future<ResponseAPI<Company>> addInformation(Company company) async {
    try {
      final res = await dioClient.post(
        '$baseURL/api/profile/company',
        data: company.toJson(),
      );
      // logger.d(res.data['create profile success']);

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

  Future<ResponseAPI<Company>> updateInformation(
      Company company, int id) async {
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

  Future<ResponseAPI<Company>> getAllInformation(
      Company company, int id) async {
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
}
