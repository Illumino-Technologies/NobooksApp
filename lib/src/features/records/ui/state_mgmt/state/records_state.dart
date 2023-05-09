part of '../records_notifier.dart';

class RecordsState extends RiverpodStateWithStatus {
  final Map<Class, List<Grade>> classGrades;

  const RecordsState({
    required this.classGrades,
    super.success = false,
    super.loading = false,
    super.error,
  });

  List<Grade> get allGrades => classGrades.values
      .reduce((value, element) => value..addAll(element))
      .toList();

  @override
  RecordsState copyWith({
    Map<Class, List<Grade>>? classGrades,
    bool? loading,
    bool? success,
    Failure? error,
  }) {
    return RecordsState(
      classGrades: classGrades ?? this.classGrades,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }
}
