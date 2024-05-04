import 'dart:async';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/notification/notification_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';
import 'package:studenthub/services/api_interceptor.dart';
import 'package:studenthub/services/dio_client.dart';
import 'package:studenthub/services/endpoint.dart';
import 'package:studenthub/utils/logger.dart';

class NotificationService {
  late DioClient dioClient;

  NotificationService() {
    var dio = Dio();
    AppInterceptors interceptors = AppInterceptors(dio);
    dioClient = DioClient(dio, interceptors: [interceptors]);
  }

  Future<ResponseAPI<List<NotificationModel>>> getNotificationList(String userId) async {
    try {
      final res = await dioClient.get('$baseURL/api/notification/getByReceiverId/$userId');

      return ResponseAPI<List<NotificationModel>>(
        statusCode: res.statusCode,
        data: List<NotificationModel>.from(res.data['result'].map((x) => NotificationModel.fromMap((x)))).toList(),
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
}
