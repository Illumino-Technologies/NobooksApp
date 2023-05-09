import 'package:dio/dio.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/error_handling/error_barrel.dart';

mixin NetworkUtilMixin {
  void throwOnFailed(Response response) {
    if (response.statusCode != 200) {
      throw Exception('Network Error');
    }
  }

  String get nonNullToken {
    try {
      return TokenManager.token!;
    } catch (e) {
      throw (Failure(message: ErrorMessages.nullToken));
    }
  }

  Options get optionsWithToken => Options(
        headers: {'Authorization': 'Bearer $nonNullToken'},
      );

  dataOf(Response response) {
    return response.data['data'] ?? response.data;
  }
}
