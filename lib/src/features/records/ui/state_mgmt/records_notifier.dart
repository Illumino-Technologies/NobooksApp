import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/records/records_barrel.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'state/records_state.dart';

StateNotifierProvider<RecordsNotifier, RecordsState> _recordsNotifierProvider =
    StateNotifierProvider(
  (ref) => RecordsNotifier(ref),
);

class RecordsNotifier extends StateNotifier<RecordsState>
    with RiverpodUtilsMixin, BasicErrorHandlerMixin {
  final RecordsSourceInterface _source;
  final ClassRepoInterface _classRepo;
  final StateNotifierProviderRef _ref;

  RecordsNotifier(
    this._ref, {
    RecordsSourceInterface? source,
    ClassRepoInterface? classRepo,
  })  : _source = source ?? RecordsSource(),
        _classRepo = classRepo ?? ClassRepository(),
        super(
          RecordsState(
            classGrades: {},
            currentClass: null,
            classes: List.empty(growable: true),
          ),
        );

  static StateNotifierProvider<RecordsNotifier, RecordsState> newProvider({
    RecordsSourceInterface? source,
    ClassRepoInterface? classRepo,
  }) {
    _recordsNotifierProvider = StateNotifierProvider(
      (ref) => RecordsNotifier(ref, source: source, classRepo: classRepo),
    );
    return _recordsNotifierProvider;
  }

  static StateNotifierProvider<RecordsNotifier, RecordsState> get provider =>
      _recordsNotifierProvider;

  Future<void> initializeNotifier() => handleError(_initializeNotifier());

  Future<void> _initializeNotifier() async {
    notifyLoading();
    await _fetchClass();
    await fetchAllGrades();
    notifySuccess();
  }

  Future<void> _fetchClass() async {
    final String studentId = _ref.read(StudentNotifier.provider)!.id;
    final List<Class> classes = await _classRepo.fetchClassesIfEmpty(
      studentId,
    );
    if (_classRepo.currentClass != null) {
      state = state.copyWith(
        currentClass: _classRepo.currentClass,
        classes: classes,
      );
      return;
    }
    final Class class_ = await _classRepo.fetchCurrentClass(studentId);

    state = state.copyWith(currentClass: class_, classes: classes);
  }

  Future<void> fetchAllGrades({bool shouldLoad = true}) => handleError(
        _fetchAllGrades(shouldLoad),
        catcher: notifyOnError,
      );

  Future<void> _fetchAllGrades(bool shouldLoad) async {
    if (shouldLoad) notifyLoading();
    final Map<Class, List<Grade>> classGrades = await _source.fetchAllGrades();
    notifySuccess(newState: state.copyWith(classGrades: classGrades));
  }

  Future<void> fetchGradesForClass(Class class_) => handleError(
        _fetchGradesForClass(class_),
        catcher: notifyOnError,
      );

  Future<void> _fetchGradesForClass(Class class_) async {
    notifyLoading();
    final List<Grade> grades = await _source.fetchGradesForClass(class_);
    notifySuccess(
      newState: state.copyWith(
        classGrades: state.classGrades..addAll({class_: grades}),
      ),
    );
  }

  Future<void> refresh({
    bool shouldLoad = true,
  }) =>
      handleError(_refresh(shouldLoad), catcher: notifyOnError);

  Future<void> _refresh(bool shouldLoad) async {
    if (shouldLoad) notifyLoading();
    await fetchAllGrades(shouldLoad: shouldLoad);
    await _classRepo.fetchStudentClasses(
      _ref.read(StudentNotifier.provider)!.id,
      fetchAFresh: true,
    );
    await _fetchClass();
    notifySuccess();
  }
}
