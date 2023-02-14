part of 'network_api.dart';

abstract class NetworkApiInterface {
  Future<T> get<T>(
    String path, {
    bool requireToken = true,
  });

  Future<T> post<T>(
    String path, {
    required dynamic params,
    bool requireToken = true,
  });

  Future<T> put<T>(
    String path, {
    required dynamic params,
    bool requireToken = true,
  });

  Future<T> patch<T>(
    String path, {
    required dynamic params,
    bool requireToken = true,
  });

  Future<T> delete<T>(
    String path, {
    bool requireToken = true,
  });
}
