import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:studenthub/data/dto/authen/request_login.dart';
import 'package:studenthub/data/dto/authen/request_register_account.dart';
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

    dioClient = DioClient(dio, interceptors: [interceptors]);
  }

  Future<ResponseAPI> login(RequestLogin requestLogin) async {
    try {
      var dio = Dio(
        BaseOptions(
            baseUrl: baseURL,
            receiveTimeout: const Duration(milliseconds: 10000), // 10 seconds
            connectTimeout: const Duration(milliseconds: 10000),
            sendTimeout: const Duration(milliseconds: 10000),
            contentType: 'application/json'),
      );
      final res = await dio.post(
        '$baseURL/api/auth/sign-in',
        data: requestLogin.toJson(),
      );

      return ResponseAPI<DataResponse>(
        statusCode: res.statusCode,
        data: DataResponse.fromJson(json.encode(res.data)),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.type}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
        data: DataResponse.fromJson(e.response.toString()),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> register(
      RequestRegisterAccount requestRegisterAccount) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseURL,
          receiveTimeout: const Duration(milliseconds: 10000), // 10 seconds
          connectTimeout: const Duration(milliseconds: 10000),
          sendTimeout: const Duration(milliseconds: 10000),
          contentType: 'application/json',
        ),
      );
      final res = await dio.post(
        '$baseURL/api/auth/sign-up',
        data: requestRegisterAccount.toJson(),
      );

      return ResponseAPI<DataResponse>(
        statusCode: res.statusCode,
        data: DataResponse.fromJson(json.encode(res.data)),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException 123 :${e.response!.data}",
      );
      throw ResponseAPI<DataResponse>(
        statusCode: e.response?.statusCode,
        data: DataResponse.fromJson(json.encode(e.response!.data)),
      );
    } catch (e) {
      logger.e("Unexpected Error 456: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> fetchInformation(String token) async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/auth/me',
      );

      logger.d(res);
      return ResponseAPI<DataResponse>(
        statusCode: res.statusCode,
        data: DataResponse.fromJson(json.encode(res.data)),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<DataResponse>(
        statusCode: e.response?.statusCode,
        data: DataResponse.fromJson(e.response.toString()),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }
}
