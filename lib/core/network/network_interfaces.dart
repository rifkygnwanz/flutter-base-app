import 'package:dio/dio.dart';
import 'api_exception.dart';

/// Base Remote Data Source class providing a utility to execute safe network calls.
abstract class RemoteDataSource {
  /// Execute a network call, automatically catching [DioException] and wrapping them in [ApiException].
  Future<T> safeCall<T>({
    required Future<Response<dynamic>> Function() call,
    required T Function(dynamic data) parser,
  }) async {
    try {
      final response = await call();
      return parser(response.data);
    } on DioException catch (dioError) {
      throw ApiException.fromDioException(dioError);
    } catch (unexpectedError) {
      throw ApiException(
        message: 'An unexpected exception occurred: $unexpectedError',
        type: ApiExceptionType.unknown,
      );
    }
  }

  /// Execute a network call returning list data.
  Future<List<T>> safeCallList<T>({
    required Future<Response<dynamic>> Function() call,
    required T Function(dynamic item) itemParser,
  }) async {
    try {
      final response = await call();
      final data = response.data;
      if (data is List) {
        return data.map((item) => itemParser(item)).toList();
      }
      throw ApiException(
        message: 'Invalid server response: Expected a list of items.',
        statusCode: response.statusCode,
        type: ApiExceptionType.badResponse,
      );
    } on DioException catch (dioError) {
      throw ApiException.fromDioException(dioError);
    } catch (unexpectedError) {
      throw ApiException(
        message: 'An unexpected exception occurred: $unexpectedError',
        type: ApiExceptionType.unknown,
      );
    }
  }
}

/// Marker base interface class for repositories.
abstract class Repository {}
