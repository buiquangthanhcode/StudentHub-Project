// const _defaultTimeout = Duration(seconds: 15);

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:studenthub/app.dart';
import 'package:studenthub/services/local_services.dart';
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
      contentType: 'application/json',
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
  final LocalStorageService _tokenService = LocalStorageService();

  AppInterceptors(this.dio);

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
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // final context = StudentHub.navigatorKey.currentContext ??;

    // if (response.statusCode == 401) {
    //   await _tokenService.clearToken();
    //   SnackBarService.showSnackBar(
    //       content: 'Your session has expired, please login again!', status: StatusSnackBar.info);
    //   Future.delayed(const Duration(milliseconds: 1000), () {
    //     Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    //   });
    // }

    return handler.next(response);
  }
}
