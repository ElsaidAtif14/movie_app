import 'package:dio/dio.dart';
import 'package:movies/core/failures/failure.dart';

class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server Exception']);

  @override
  String toString() => 'ServerException: $message';
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network Exception']);

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache Exception']);

  @override
  String toString() => 'CacheException: $message';
}

class ApiExceptions {
  static Failure handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const NetworkFailure('Network error. Please check your connection and try again.');
    }

    if (e.type == DioExceptionType.badCertificate) {
      return const NetworkFailure('Invalid SSL certificate.');
    }

    if (e.type == DioExceptionType.cancel) {
      return const NetworkFailure('Request was cancelled.');
    }

    if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode ?? 0;
      final message = e.response?.statusMessage ?? 'Server error.';
      return _mapStatusCodeToFailure(statusCode, message);
    }

    if (e.type == DioExceptionType.unknown) {
      return const UnexpectedFailure('An unknown error occurred.');
    }

    return UnexpectedFailure(e.message ?? 'Unexpected error.');
  }

  static Failure _mapStatusCodeToFailure(int statusCode, String message) {
    switch (statusCode) {
      case 400:
        return BadRequestFailure(message.isNotEmpty ? message : 'Bad request.');
      case 401:
      case 403:
        return const UnauthorizedFailure('Unauthorized access.');
      case 404:
        return const NotFoundFailure('Requested resource could not be found.');
      case 408:
        return const NetworkFailure('Request timeout. Please try again later.');
      case 500:
      case 502:
      case 503:
      case 504:
        return const ServerFailure('Server error. Please try again later.');
      default:
        return ServerFailure(message.isNotEmpty ? message : 'Server error.');
    }
  }
}
