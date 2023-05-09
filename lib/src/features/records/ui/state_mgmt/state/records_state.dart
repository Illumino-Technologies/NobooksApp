part of '../records_notifier.dart';

class RecordsState extends RiverpodStateWithStatus {
  final Map<Class, List<Grade>> classGrades;
  final Class? _currentClass;
  final List<Class> classes;

  const RecordsState({
    required this.classes,
    required this.classGrades,
    required Class? currentClass,
    super.success = false,
    super.loading = false,
    super.error,
  }) : _currentClass = currentClass;

  Class? get currentClass => _currentClass;

  List<Grade> get allGrades =>
      classGrades.values.fold<List<Grade>>([], (previousValue, element) {
        return previousValue..addAll(element);
      });

  @override
  RecordsState copyWith({
    Map<Class, List<Grade>>? classGrades,
    bool? loading,
    bool? success,
    Failure? error,
    Class? currentClass,
    List<Class>? classes,
  }) {
    return RecordsState(
      classes: classes ?? this.classes,
      currentClass: currentClass ?? _currentClass,
      classGrades: classGrades ?? this.classGrades,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }
}
