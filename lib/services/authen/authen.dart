import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/authen/request_login.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/services/api_interceptor.dart';
import 'package:studenthub/services/dio_client.dart';
import 'package:studenthub/services/endpoint.dart';
import 'package:studenthub/utils/logger.dart';

class AuthService {
  late DioClient dioClient;

  AuthService() {
    var dio = Dio();
    AppInterceptors interceptors = AppInterceptors(dio);

    dioClient = DioClient("", dio, interceptors: [interceptors]);
  }

  Future<ResponseAPI> login(RequestLogin requestLogin) async {
    var dio = Dio();
    try {
      final res = await dio.post(
        '${baseURL}api/auth/sign-in',
        data: requestLogin.toJson(),
      );
      return ResponseAPI(
        statusCode: res.statusCode,
        data: DataResponse.fromJson(json.encode(res.data)),
      );
    } on DioException catch (e) {
      logger.e(
        "Error:${e.response}",
      );
      return ResponseAPI(
        statusCode: e.response?.statusCode,
        data: DataResponse.fromJson(e.response.toString()),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }
}
