import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

StateNotifierProvider<SchoolNotifier, School?> _schoolProvider =
    StateNotifierProvider<SchoolNotifier, School?>(
  (ref) => SchoolNotifier(null),
);

class SchoolNotifier extends StateNotifier<School?>
    with StateCrudMixin<School?> {
  static StateNotifierProvider<SchoolNotifier, School?> get provider =>
      _schoolProvider;

  void refresh(){
  }

  void initialize(){
    state =
  }

  SchoolNotifier(super.state);
}
