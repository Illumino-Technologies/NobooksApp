import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

final StateNotifierProvider<StudentNotifier, Student?> _studentProvider =
    StateNotifierProvider<StudentNotifier, Student?>(
  (ref) => StudentNotifier(FakeUsers.bolu),
);

class StudentNotifier extends StateNotifier<Student?>
    with StateCrudMixin<Student> {
  StudentNotifier(super.state);

  static final StateNotifierProvider<StudentNotifier, Student?> provider =
      _studentProvider;
}
