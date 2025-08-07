import 'package:dio/dio.dart';
import 'package:flutter_moviedb/core/data/datasource/dio/network_exception.dart';

class NetworkInterceptor extends Interceptor{
  final Dio dio;
  NetworkInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMzgxZDNhOWFlYjZkN2M0OWVlZGNmNDRiNGFhZDVlNyIsIm5iZiI6MTY1MTAyODc4NS45OSwic3ViIjoiNjI2OGIzMzExOTY3NTcwMGFiYTBkMjEzIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.vNCXqJx1l8tQ30LXCNS4xDl3DrNIs_gvnyvmQvLuNKk';
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    throw NetworkException(
      requestOptions: err.requestOptions,
      exception: err,
    );
  }


}