import 'dart:developer' as dev;
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    dev.log(
      '--> [REQ] ${options.method.toUpperCase()} ${options.uri}',
      name: 'Network',
    );
    if (options.headers.isNotEmpty) {
      dev.log('Headers: ${options.headers}', name: 'Network');
    }
    if (options.data != null) {
      dev.log('Body: ${options.data}', name: 'Network');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    dev.log(
      '<-- [RES] ${response.statusCode} ${response.requestOptions.method.toUpperCase()} ${response.requestOptions.uri}',
      name: 'Network',
    );
    dev.log('Response: ${response.data}', name: 'Network');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    dev.log(
      '<-- [ERR] ${err.response?.statusCode} ${err.requestOptions.method.toUpperCase()} ${err.requestOptions.uri}',
      name: 'Network',
      error: err.error,
      stackTrace: err.stackTrace,
    );
    if (err.response?.data != null) {
      dev.log('Error Data: ${err.response?.data}', name: 'Network');
    }
    return super.onError(err, handler);
  }
}
