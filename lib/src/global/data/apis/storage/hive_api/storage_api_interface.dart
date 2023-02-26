part of 'storage_api.dart';

abstract class StorageApiInterface<T> {
  T? fetch(
    String key, {
    T? defaultValue,
  });

  Future<void> put(String key, T data);

  Future<void> delete(String key);

  Future<void> deleteAll();
}
