import 'package:hive_flutter/hive_flutter.dart';
import 'package:nobook/src/global/data/apis/storage/storage_api_barrel.dart';

part 'storage_api_interface.dart';

class StorageApi<T>
    with HiveErrorHandlerMixin
    implements StorageApiInterface<T> {
  final Box<T> _box;

  StorageApi({
    required String boxKey,
  }) : _box = Hive.box(boxKey);

  static Future<void> initialize() async {
    await Hive.initFlutter();
  }

  @override
  Future<void> delete(String key) => handleError(_delete(key));

  Future<void> _delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> deleteAll() async {
    await _box.clear();
  }

  @override
  T? fetch(String key, {T? defaultValue}) {
    final T? data = _box.get(key, defaultValue: defaultValue);
    return data;
  }

  @override
  Future<void> put(String key, data) async {
    await _box.put(key, data);
  }
}
