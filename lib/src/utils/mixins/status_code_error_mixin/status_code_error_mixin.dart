import 'package:dio/dio.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

mixin StatusCodeErrorMixin {
  void throwOnFailedRequest(
    final Response response, {
    int statusCode = 200,
    String errorMessage = ErrorMessages.requestUnsuccessful,
  }) {
    if (response.statusCode != statusCode) {
      throw (errorMessage);
    }
  }
}
