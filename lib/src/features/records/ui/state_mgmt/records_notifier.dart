import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/records/data/data_source/records_source.dart';
import 'package:nobook/src/features/records/records_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'state/records_state.dart';

StateNotifierProvider<RecordsNotifier, RecordsState> _recordsNotifierProvider =
    StateNotifierProvider(
  (ref) => RecordsNotifier(),
);

class RecordsNotifier extends StateNotifier<RecordsState>
    with RiverpodUtilsMixin, BasicErrorHandlerMixin {
  final RecordsSourceInterface _source;

  RecordsNotifier({
    RecordsSourceInterface? source,
  })  : _source = source ?? RecordsSource(),
        super(const RecordsState(classGrades: {}));

  Future<void> fetchAllGrades() => handleError(
        _fetchAllGrades(),
        catcher: notifyOnError,
      );

  static StateNotifierProvider<RecordsNotifier, RecordsState> newProvider({
    RecordsSourceInterface? source,
  }) {
    _recordsNotifierProvider = StateNotifierProvider(
      (ref) => RecordsNotifier(source: source),
    );
    return _recordsNotifierProvider;
  }

  static StateNotifierProvider<RecordsNotifier, RecordsState> get provider =>
      _recordsNotifierProvider;

  Future<void> _fetchAllGrades() async {
    notifyLoading();
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
}
