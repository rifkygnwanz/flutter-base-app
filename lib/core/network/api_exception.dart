import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;
  final ApiExceptionType type;

  ApiException({
    required this.message,
    this.statusCode,
    this.details,
    this.type = ApiExceptionType.unknown,
  });

  factory ApiException.fromDioException(DioException error) {
    String message = 'An unexpected network error occurred. Please try again.';
    ApiExceptionType type = ApiExceptionType.unknown;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message =
            'Connection to the server timed out. Please check your internet connection.';
        type = ApiExceptionType.timeout;
        break;
      case DioExceptionType.sendTimeout:
        message = 'Sending data to the server timed out. Please try again.';
        type = ApiExceptionType.timeout;
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Server response timeout. Please try again later.';
        type = ApiExceptionType.timeout;
        break;
      case DioExceptionType.badCertificate:
        message =
            'Security certificate verification failed. Safe connection could not be established.';
        type = ApiExceptionType.security;
        break;
      case DioExceptionType.badResponse:
        final response = error.response;
        final code = response?.statusCode;
        type = ApiExceptionType.badResponse;

        if (code != null) {
          if (code == 400) {
            message =
                _parseErrorMessage(response?.data) ??
                'Invalid request submitted.';
            type = ApiExceptionType.badRequest;
          } else if (code == 401) {
            message = 'Session expired. Please log in again.';
            type = ApiExceptionType.unauthorized;
          } else if (code == 403) {
            message = 'You do not have permission to access this resource.';
            type = ApiExceptionType.forbidden;
          } else if (code == 404) {
            message = 'Requested resource was not found.';
            type = ApiExceptionType.notFound;
          } else if (code == 422) {
            message =
                _parseErrorMessage(response?.data) ??
                'Validation errors occurred.';
            type = ApiExceptionType.validation;
          } else if (code >= 500) {
            message = 'Internal server error. Please try again later.';
            type = ApiExceptionType.server;
          }
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request to the server was cancelled.';
        type = ApiExceptionType.cancel;
        break;
      case DioExceptionType.connectionError:
        message =
            'Failed to connect to the server. Please verify your internet connection.';
        type = ApiExceptionType.network;
        break;
      case DioExceptionType.unknown:
        if (error.error != null &&
            error.error.toString().contains('SocketException')) {
          message =
              'No internet connection detected. Please connect and try again.';
          type = ApiExceptionType.network;
        } else {
          message = error.message ?? message;
        }
        break;
    }

    return ApiException(
      message: message,
      statusCode: error.response?.statusCode,
      details: error.response?.data,
      type: type,
    );
  }

  static String? _parseErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data.containsKey('message') && data['message'] is String) {
        return data['message'] as String;
      }
      if (data.containsKey('error') && data['error'] is String) {
        return data['error'] as String;
      }
    }
    return null;
  }

  @override
  String toString() =>
      'ApiException(message: $message, statusCode: $statusCode, type: $type)';
}

enum ApiExceptionType {
  timeout,
  security,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  validation,
  server,
  network,
  cancel,
  badResponse,
  unknown,
}
