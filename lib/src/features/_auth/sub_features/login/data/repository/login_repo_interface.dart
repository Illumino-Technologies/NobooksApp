import 'package:nobook/src/features/_auth/auth_feature_barrel.dart';
import 'package:nobook/src/global/data/apis/network/network_api_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/constants/constants_barrel.dart';

part 'login_repository.dart';

abstract interface class LoginRepositoryInterface {
  Future<void> login({
    required String studentId,
    required String password,
  });
}
