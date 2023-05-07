import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nobook/src/global/data/apis/network/network_api_barrel.dart';
import 'package:nobook/src/global/domain/logics/token_manager/token_manager.dart';
import 'package:nobook/src/utils/utils_barrel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkApi with DioErrorHandlerMixin {
  final Dio _client;

  NetworkApi._({
    Dio? client,
  }) : _client = client ?? Dio() {
    _initialize();
  }

  static final NetworkApi instance = NetworkApi._();

  factory NetworkApi() => instance;

  Dio get client => _client;
  static const int pageLength = 25;

  void changeTokenInHeaders([String? token]) {
    token = token ?? TokenManager.token;
    if (token.isNullOrEmpty) return;
    client.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<void> _initialize() async {
    final String? authToken = TokenManager.token;
    debugPrint("authToken: $authToken");
    if (authToken.isNotNullOrEmpty) {
      client.options.contentType = Headers.jsonContentType;
      client.options.headers["Authorization"] = 'Bearer $authToken';
    }

    client.options.connectTimeout = const Duration(seconds: 20);
    client.options.sendTimeout = const Duration(seconds: 20);

    final RegExp htmlRegex = RegExp(r'<[a-z]*>', multiLine: true);

    client.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e, handler) async {
          if (e.response?.data.runtimeType == String &&
              htmlRegex.hasMatch(e.response?.data)) {
            e.response!.data = ErrorMessages.serverError;
          }
          return handler.next(e);
        },
      ),
    );

    client.interceptors.add(
      PrettyDioLogger(responseBody: true, requestBody: true),
    );
  }
}
