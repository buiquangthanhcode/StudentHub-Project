import 'dart:async';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/chat_model.dart';
import 'package:studenthub/models/common/message_model.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/services/api_interceptor.dart';
import 'package:studenthub/services/dio_client.dart';
import 'package:studenthub/services/endpoint.dart';
import 'package:studenthub/utils/logger.dart';

class ChatService {
  late DioClient dioClient;

  ChatService() {
    var dio = Dio();
    AppInterceptors interceptors = AppInterceptors(dio);
    dioClient = DioClient(dio, interceptors: [interceptors]);
  }

  Future<ResponseAPI<List<Chat>>> getAllData() async {
    try {
      final res = await dioClient.get('$baseURL/api/message');

      return ResponseAPI<List<Chat>>(
        statusCode: res.statusCode,
        data: res.data['result'].map<Chat>((x) => Chat.fromMap(x)).toList(),
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

  Future<ResponseAPI<List<Message>>> getAllChatWithUserId(
      String userId, String projectId) async {
    try {
      final res =
          await dioClient.get('$baseURL/api/message/$projectId/user/$userId');
      logger.d('CHAT DATA: ${res.data}');
      return ResponseAPI<List<Message>>(
        statusCode: res.statusCode,
        data:
            res.data['result'].map<Message>((x) => Message.fromMap(x)).toList(),
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
