import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'fake_auth_source.dart';

part 'network_auth_source.dart';

abstract interface class AuthSourceInterface {
  Future<NamedPair<Student, String>> login({
    required String studentID,
    required String password,
  });

  Future<String> changePassword({
    required String studentId,
    required String password,
  });

  Future<void> requestLoginDetails({
    required String schoolId,
    required String email,
    required String fullName,
  });

  Future<void> logout();
}
