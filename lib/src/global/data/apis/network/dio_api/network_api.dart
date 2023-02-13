import 'package:dio/dio.dart';
import 'package:nobook/src/global/data/apis/network/network_api_barrel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'network_api_interface.dart';

class NetworkApi with DioErrorHandlerMixin implements NetworkApiInterface {
  final Dio _client;

  NetworkApi._({
    Dio? client,
  }) : _client = client ?? Dio() {
    _initialize();
  }

  Future<void> _initialize() async {
    //todo: fetch and set token
    _client.interceptors.add(PrettyDioLogger());
  }

  static final NetworkApi instance = NetworkApi._();

  factory NetworkApi() => instance;

  @override
  Future<T> delete<T>(
    String path, {
    bool requireToken = true,
  }) =>
      handleError(_delete(path, requireToken: requireToken));

  Future<T> _delete<T>(
    String path, {
    bool requireToken = true,
  }) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<T> get<T>(
    String path, {
    bool requireToken = true,
  }) =>
      handleError(_get(path, requireToken: requireToken));

  Future<T> _get<T>(
    String path, {
    bool requireToken = true,
  }) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<T> patch<T>(
    String path, {
    required dynamic params,
    bool requireToken = true,
  }) =>
      handleError(_patch(path, params: params, requireToken: requireToken));

  Future<T> _patch<T>(
    String path, {
    required dynamic params,
    bool requireToken = true,
  }) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<T> post<T>(
    String path, {
    required dynamic params,
    bool requireToken = true,
  }) =>
      handleError(_post(path, params: params, requireToken: requireToken));

  Future<T> _post<T>(
    String path, {
    required dynamic params,
    bool requireToken = true,
  }) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<T> put<T>(
    String path, {
    required dynamic params,
    bool requireToken = true,
  }) =>
      handleError(_put(path, params: params, requireToken: requireToken));

  Future<T> _put<T>(
    String path, {
    required dynamic params,
    bool requireToken = true,
  }) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
