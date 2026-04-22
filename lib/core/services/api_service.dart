import 'package:dio/dio.dart';
import 'package:movies/core/exceptions/custom_exceptions.dart';
import 'package:movies/core/failures/failure.dart';
import 'package:movies/core/network/dio_client.dart';
import 'package:movies/core/services/database_service.dart';

class ApiServiceImpl implements DatabaseService {
  final DioClient _dioClient;

  ApiServiceImpl(this._dioClient);

  @override
  Future<dynamic> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw UnexpectedFailure(
        'Unexpected error while fetching data from $endPoint.',
      );
    }
  }

  @override
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw UnexpectedFailure('Unexpected error while posting to $endPoint.');
    }
  }

  @override
  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw UnexpectedFailure('Unexpected error while updating $endPoint.');
    }
  }

  @override
  Future<dynamic> delete(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw UnexpectedFailure(
        'Unexpected error while deleting resource at $endPoint.',
      );
    }
  }
}
