import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/chat_model.dart';
import 'package:studenthub/models/common/interview_model.dart';
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

  Future<ResponseAPI<dynamic>> updateInterview(int id, dynamic data_) async {
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

  Future<ResponseAPI<bool>> checkAvailability(String code, String id) async {
    try {
      final res = await dioClient
          .get('$baseURL/meeting-room/check-availability', queryParameters: {
        "meeting_room_code": code,
        "meeting_room_id": id,
      });

      // logger.d('CHECK AVAILABILITY: ${res.data}');

      return ResponseAPI<bool>(
        statusCode: res.statusCode,
        data: res.data['result'],
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

  Future<ResponseAPI<List<Interview>>> getActiveInterview(String userId) async {
    try {
      final res = await dioClient.get('$baseURL/api/interview/user/$userId');

      logger.d('INTERVIEW ACTIVE: ${res.data}');

      List<Interview> data = res.data['result']
          .map<Interview>((x) => Interview.fromMap(x))
          .toList();

      return ResponseAPI<List<Interview>>(
        statusCode: res.statusCode,
        data: data.reversed.toList(),
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
