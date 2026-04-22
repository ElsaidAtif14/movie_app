import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient._(this.dio);

  factory DioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        queryParameters: {
          'api_key': ApiConstants.apiKey,
          'language': 'en-US',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.addAll(
            {
              'api_key': ApiConstants.apiKey,
              'language': 'en-US',
            },
          );
          if (kDebugMode) {
            debugPrint('Dio Request => ${options.method} ${options.uri}');
            debugPrint('Headers: ${options.headers}');
            debugPrint('Query: ${options.queryParameters}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint('Dio Response => ${response.statusCode} ${response.realUri}');
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            debugPrint('Dio Error => ${error.message}');
          }
          handler.next(error);
        },
      ),
    );

    return DioClient._(dio);
  }
}
