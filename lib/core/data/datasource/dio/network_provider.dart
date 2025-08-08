import 'package:dio/dio.dart';
import 'package:flutter_moviedb/core/data/datasource/dio/endpoints.dart';
import 'package:flutter_moviedb/core/data/datasource/dio/network_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkProviderDio {
  late Dio _dio;

  NetworkProviderDio() {
    createInstance();
  }

  Future<Dio> createInstance() async {
    Duration timeoutDuration = const Duration(
      seconds: Endpoints.connectTimeout,
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: timeoutDuration,
        receiveTimeout: timeoutDuration,
        sendTimeout: timeoutDuration,
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.addAll({
      NetworkInterceptor(_dio),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    });

    return _dio;
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
