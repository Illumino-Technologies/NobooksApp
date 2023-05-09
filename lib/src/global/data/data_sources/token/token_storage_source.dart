import 'package:hive_flutter/hive_flutter.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'token_storage_service_interface.dart';

class TokenStorageSource implements TokenStorageSourceInterface {
  late final Box<String> tokenBox;

  TokenStorageSource._({
    Box<String>? mockBox,
  }) : tokenBox = mockBox ?? Hive.box<String>(StorageKey.token.box);

  static final TokenStorageSource _instance = TokenStorageSource._();

  static TokenStorageSource get instance => _instance;

  factory TokenStorageSource.test({
    Box<String>? mockBox,
  }) =>
      TokenStorageSource._(
        mockBox: mockBox,
      );

  factory TokenStorageSource() => instance;

  @override
  String? getUserToken() => tokenBox.get(StorageKey.token.key);

  @override
  Future<void> removeUserToken() async {
    await tokenBox.delete(StorageKey.token.key);
  }

  @override
  Future<void> storeToken(token) async {
    await tokenBox.put(StorageKey.token.key, token);
  }
}
