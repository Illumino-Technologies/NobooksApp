// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'private.dart';

StateNotifierProvider<_StudentNotifier, Student?>? _provider;

abstract final class StudentManager {
  static final _StudentNotifier _notifier = _StudentNotifier(null);

  static StateNotifierProvider<_StudentNotifier, Student?> get provider {
    _provider ??= StateNotifierProvider<_StudentNotifier, Student?>(
      (ref) => _notifier,
    );
    return _provider!;
  }

  static Student? get student => _notifier.readData;

  static Future<Student> get requireStudent async {
    final Student student = await const FakeStudentSource().fetchStudent();
    storeStudent(student);
    return student;
  }

  static void storeStudent(Student student) => _notifier.createData(student);

  static void clearStudent() => _notifier.deleteData();
}
