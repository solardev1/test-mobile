import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasks/core/networking/error_model.dart';


typedef DT<M> = Either<ErrorModel, M>;

class NetworkClient {
  NetworkClient({
    required this.client,
  });

  final Dio client;
  Future<DT<T>> post<T>({
    T Function(Map<String, dynamic>)? fromJsonFunction,
    T Function(List<Map<String, dynamic>>)? fromJsonFunctionList,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? aditionalHeaders,
    dynamic body,
  }) async {
    final options = Options(
      headers: aditionalHeaders,
    );
    try {
      if (fromJsonFunctionList != null) {
        final response = await client.post<List<dynamic>>(
          path,
          queryParameters: queryParameters,
          data: body,
          options: options,
        );

        final listData = response.data! as List<dynamic>;
        final convertedList =
            listData.map((item) => item as Map<String, dynamic>).toList();

        return Right(
          fromJsonFunctionList(convertedList),
        );
      } else {
        final response = await client.post<Map<String, dynamic>>(
          path,
          queryParameters: queryParameters,
          data: body,
          options: options,
        );
        return Right(
          fromJsonFunction!(response.data!),
        );
      }
    } catch (e) {
      return Left(
        ErrorModel.exception(
          exception: e,
        ),
      );
    }
  }

  Future<DT<T>> get<T>({
    required String path,
    T Function(Map<String, dynamic>)? fromJsonFunction,
    T Function(List<Map<String, dynamic>>)? fromJsonFunctionList,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? additionalHeaders,
  }) async {
    final options = Options(
      headers: additionalHeaders,
    );
    try {
      if (fromJsonFunctionList != null) {
        final response = await client.get<List<dynamic>>(
          path,
          queryParameters: queryParameters, 
          options: options
          );
        final listData = response.data! as List<dynamic>;
        final convertedList =
            listData.map((item) => item as Map<String, dynamic>).toList();

        return Right(
          fromJsonFunctionList(convertedList),
        );
      } else {
        final response = await client.get<Map<String, dynamic>>(path,
            queryParameters: queryParameters, options: options);
        return Right(
          fromJsonFunction!(response.data!),
        );
      }
    } catch (exception) {
      return Left(
        ErrorModel.exception(
          exception: exception,
        ),
      );
    }
  }

  Future<DT<T>> put<T>({
    required T Function(Map<String, dynamic>) fromJsonFunction,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? additionalHeaders,
    dynamic body,
  }) async {
    final options = Options(
      headers: additionalHeaders,
    );
    try {
      final response = await client.put<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        data: body,
        options: options,
      );
      return Right(
        fromJsonFunction(response.data!),
      );
    } catch (e) {
      return Left(
        ErrorModel.exception(
          exception: e,
        ),
      );
    }
  }

  Future<DT<T>> delete<T>({
    required T Function(Map<String, dynamic>) fromJsonFunction,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? additionalHeaders,
    dynamic body,
  }) async {
    final options = Options(
      headers: additionalHeaders,
    );
    try {
      final response = await client.delete<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        data: body,
        options: options,
      );
      return Right(
        fromJsonFunction(response.data!),
      );
    } catch (e) {
      return Left(
        ErrorModel.exception(
          exception: e,
        ),
      );
    }
  }
}
