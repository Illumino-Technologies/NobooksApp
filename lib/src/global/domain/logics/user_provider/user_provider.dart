import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

final StateNotifierProvider<UserNotifier, User?> _userProvider =
    StateNotifierProvider<UserNotifier, User?>(
  (ref) => UserNotifier(FakeUsers.bolu),
);

class UserNotifier extends StateNotifier<User?> with StateCrudMixin<User> {
  UserNotifier(super.state);

  static final StateNotifierProvider<UserNotifier, User?> provider =
      _userProvider;
}
