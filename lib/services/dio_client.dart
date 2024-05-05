import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studenthub/utils/logger.dart';

const _defaultConnectTimeout = 10000;
const _defaultReceiveTimeout = 10000;

class DioClient {
  late Dio _dio;

  final List<Interceptor> interceptors;
  // Global options

  DioClient(
    Dio dio, {
    required this.interceptors,
  }) {
    _dio = dio;
    _dio
      ..options.connectTimeout = const Duration(milliseconds: _defaultConnectTimeout)
      ..options.receiveTimeout = const Duration(milliseconds: _defaultReceiveTimeout)
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json'}
      ..options.headers = {'accept': '*/*'};

    if (interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
    if (kDebugMode) {
      // _dio.interceptors.add(
      //   // LogInterceptor(
      //   //   responseBody: false,
      //   //   error: true,
      //   //   requestHeader: false,
      //   //   responseHeader: false,
      //   //   request: false,
      //   //   requestBody: false,
      //   // ),
      // );
    }
  }

  FutureOr<Response> get(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options = Options(
        receiveTimeout: const Duration(milliseconds: 6000),
        receiveDataWhenStatusError: true,
        persistentConnection: false,
        method: 'get',
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      );
      var response = await _dio.get(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options = Options(
        receiveTimeout: const Duration(milliseconds: 6000),
        receiveDataWhenStatusError: true,
        persistentConnection: false,
        method: 'post',
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      );
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<Response> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
}

String handleDioError(DioExceptionType error) {
  String message = '';
  if (error == DioExceptionType.connectionTimeout) {
    message = 'Connection timeout occurred';
  } else if (error == DioExceptionType.receiveTimeout) {
    message = 'Receive timeout occurred';
  } else if (error == DioExceptionType.sendTimeout) {
    message = 'Send timeout occurred';
  } else if (error == DioExceptionType.cancel) {
    message = 'Request to server was cancelled';
  } else if (error == DioExceptionType.badResponse) {
    message = 'Bad response from server';
  } else {
    message = 'Unexpected error occurred';
  }
  return message;
}

Future<String> getPath(String filename) async {
  String directory;
  if (Platform.isIOS) {
    directory = (await getDownloadsDirectory())?.path ?? (await getTemporaryDirectory()).path;
  } else {
    directory = '/storage/emulated/0/Download';
    var dirDownloadExists = true;
    dirDownloadExists = await Directory(directory).exists();
    if (!dirDownloadExists) {
      directory = '/storage/emulated/0/Downloads';
      dirDownloadExists = await Directory(directory).exists();
      if (!dirDownloadExists) {
        directory = (await getTemporaryDirectory()).path;
      }
    }
  }
  return "$directory/$filename";
}
