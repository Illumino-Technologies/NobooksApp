part of 'token_storage_source.dart';

abstract class TokenStorageSourceInterface {
  Future<void> storeToken(token);

  String? getUserToken();

  Future<void> removeUserToken();
}
