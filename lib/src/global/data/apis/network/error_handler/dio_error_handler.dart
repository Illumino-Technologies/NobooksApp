import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

mixin DioErrorHandlerMixin {
  Future<T> handleError<T>(
    Future<T> computation, {
    ErrorFallback<T>? catcher,
  }) async {
    try {
      return await computation;
    } on DioError catch (e, stackTrace) {
      Failure failure = Failure(stackTrace: stackTrace);

      switch (e.type) {
        case DioErrorType.connectionTimeout:
          debugPrint('Connection TimeOut:');
          debugPrint(e.message);
          debugPrint(e.response.toString());
          debugPrint(e.response.toString());

          failure = failure.copyWith(
            message: ErrorMessages.connectionTimeOut,
          );
          break;
        case DioErrorType.sendTimeout:
          debugPrint('Send Time out');
          failure = failure.copyWith(message: ErrorMessages.sendTimeOut);
          break;
        case DioErrorType.receiveTimeout:
          debugPrint('receive time out');
          failure = failure.copyWith(message: ErrorMessages.receiveTimeOut);
          break;
        case DioErrorType.badResponse:
          {
            String? errorMessage;
            final int statusCode = e.response?.statusCode ?? 0;
            if (statusCode >= 500) {
              errorMessage = errorMessage ?? ErrorMessages.serverError;
            } else if (statusCode >= 400 && statusCode < 500) {
              errorMessage = errorMessage ?? ErrorMessages.clientError;
            } else if (statusCode >= 300 && statusCode < 400) {
              errorMessage = errorMessage ?? ErrorMessages.anErrorOccurred;
            } else if (statusCode >= 100 && statusCode < 200) {
              errorMessage = errorMessage ?? e.message;
            }
            errorMessage = errorMessage ?? e.message;

            failure = failure.copyWith(
              message: errorMessage,
            );
            break;
          }
        case DioErrorType.cancel:
          debugPrint(ErrorMessages.requestCancelled);
          failure = failure.copyWith(message: ErrorMessages.requestCancelled);
          break;
        case DioErrorType.badCertificate:
        case DioErrorType.unknown:
          failure = failure.copyWith(message: e.message);
          break;
        case DioErrorType.connectionError:
          // TODO: Handle this case.
          break;
      }
      debugPrint(failure.toString());
      return catcher?.call(failure) ?? Future.error(failure);
    } catch (e, stackTrace) {
      late Failure failure;
      if (e is! Failure) {
        failure = Failure(message: '$e', stackTrace: stackTrace);
      } else {
        failure = e;
      }

      debugPrint('$failure');

      return catcher?.call(failure) ?? Future.error(failure);
    }
  }
}
