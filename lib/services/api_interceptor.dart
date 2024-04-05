// const _defaultTimeout = Duration(seconds: 15);

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:studenthub/app.dart';
import 'package:studenthub/services/token_services.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class AppInterceptors extends Interceptor {
  static final navigatorKey = GlobalKey<NavigatorState>();

  Dio dio = Dio(
    BaseOptions(
      baseUrl: '',
      receiveTimeout: const Duration(milliseconds: 30000), // 30 seconds
      connectTimeout: const Duration(milliseconds: 30000),
      sendTimeout: const Duration(milliseconds: 30000),
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  // Global options
  final options = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),
    // Default.
    policy: CachePolicy.request,
    // Optional. Returns a cached responpse on error but for statuses 401 & 403.
    //hitCacheOnErrorExcept: [401, 403],
    // Optional. Overrides any HTTP directive to delete entry past this duration.
    maxStale: const Duration(days: 7),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended.
    allowPostMethod: false,
  );
  final TokenService _tokenService = TokenService();

  AppInterceptors(this.dio);

  // Add by Quang Thanh to attemp request when error
  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   return dio.request<dynamic>(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = "Bearer $token";
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.e(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path} \n => BODY: ${err.requestOptions.data}');
    // Check if the error is a 401 Unauthorized
    // Continue with error handling
    return handler.next(err);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final context = StudentHub.navigatorKey.currentContext!;

    if (response.statusCode == 401) {
      _tokenService.clearToken();
      SnackBarService.showSnackBar(
          content: 'Your session has expired, please login again!', status: StatusSnackBar.info);
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      });
    }

    return handler.next(response);
  }
}
