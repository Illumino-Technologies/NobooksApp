import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/global/domain/fakes/fakes_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

StateNotifierProvider<SchoolNotifier, School?> _schoolProvider =
    StateNotifierProvider<SchoolNotifier, School?>(
  (ref) => SchoolNotifier(null)..initialize(),
);

class SchoolNotifier extends StateNotifier<School?>
    with StateCrudMixin<School?> {
  static StateNotifierProvider<SchoolNotifier, School?> get provider =>
      _schoolProvider;

  void refresh() {
    _schoolProvider = StateNotifierProvider<SchoolNotifier, School?>(
      (ref) => SchoolNotifier(null)..initialize(),
    );
  }

  void initialize() {
    state = FakeSchoolData.school;
  }

  SchoolNotifier(super.state);
}
