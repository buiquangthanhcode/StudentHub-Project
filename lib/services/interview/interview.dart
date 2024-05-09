import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/chat_model.dart';
import 'package:studenthub/models/common/message_model.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/services/api_interceptor.dart';
import 'package:studenthub/services/dio_client.dart';
import 'package:studenthub/services/endpoint.dart';
import 'package:studenthub/utils/logger.dart';

class InterviewService {
  late DioClient dioClient;

  InterviewService() {
    var dio = Dio();
    AppInterceptors interceptors = AppInterceptors(dio);
    dioClient = DioClient(dio, interceptors: [interceptors]);
  }

    Future<ResponseAPI<dynamic>> sendInterview(dynamic data_) async {
    try {
      final res = await dioClient.post(
        '$baseURL/api/interview',
        data: json.encode(data_),
      );

      // logger.d('CHAT DATA: ${res.data}');

      return ResponseAPI<dynamic>(
        statusCode: res.statusCode,
        data: res.data,
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

  Future<ResponseAPI<dynamic>> updateInterview(int id,dynamic data_) async {
    try {
      final res = await dioClient.patch(
        '$baseURL/api/interview/$id',
        data: json.encode(data_),
      );

      logger.d('UPDATE INTERVIEW: ${res.data}');

      return ResponseAPI<dynamic>(
        statusCode: res.statusCode,
        data: res.data,
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

    Future<ResponseAPI<dynamic>> cancelInterview(int id) async {
    try {
      final res = await dioClient.patch(
        '$baseURL/api/interview/$id/disable',
      );

      logger.d('CANCEL INTERVIEW: ${res.data}');

      return ResponseAPI<dynamic>(
        statusCode: res.statusCode,
        data: res.data,
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

  Future<ResponseAPI<bool>> checkAvailability() async {
    try {
      final res = await dioClient.get('$baseURL/api/message');

      return ResponseAPI<bool>(
        statusCode: res.statusCode,
        data: true,
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
}
