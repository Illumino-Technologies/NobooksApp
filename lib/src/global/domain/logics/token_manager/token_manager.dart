import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'private.dart';

class TokenManager {
  static final _TokenNotifier _notifier = _TokenNotifier();

  static String? get token => _notifier.readData;

  static void storeToken(String token) => _notifier.createData(token);

  static void clearToken() => _notifier.deleteData();
}
