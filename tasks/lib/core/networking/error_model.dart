import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tasks/core/errors/connection_exception.dart';
import 'package:tasks/core/errors/error_type.dart';

class ErrorModel extends Equatable{
  // ignore: prefer_const_constructors_in_immutables
  const ErrorModel({
    this.message = 'Ocurrio un error',
    this.type = ErrorType.critical,
  });

  factory ErrorModel.exception({
    required dynamic exception
    }){
    final message = exception.toString();
    const errorType = ErrorType.critical;

    switch (exception.runtimeType) {
      case NoInternetConnectionException:
        return const ErrorModel(
          message: 'No internet connection',
          type: ErrorType.network,
        );
        case DioException:
        if (exception is DioException) {
            return const ErrorModel(
              message: 'DioException error',
              type: ErrorType.critical,
            );
        } else {
          return const ErrorModel(
            message: 'DioException error',
            type: ErrorType.info,
          );
        }
      default:
      // todo: consider adding a default error message for unhandled exceptions
      debugPrint('ErrorModel.exception: $exception');
        return ErrorModel(
          message: message,
          type: errorType,
        );
    }
  }

  final String message;
  final ErrorType type;
  
  @override
  List<Object?> get props => [message, type];
}
