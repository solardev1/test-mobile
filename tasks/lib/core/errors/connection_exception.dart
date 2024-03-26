import 'package:dio/dio.dart';

class NoInternetConnectionException extends DioError implements Exception {
  NoInternetConnectionException({
    required super.requestOptions,
  });
}
