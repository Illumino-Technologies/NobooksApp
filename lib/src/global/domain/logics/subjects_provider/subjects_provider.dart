import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';

final StateNotifierProvider<SubjectsNotifier, List<Subject>> _subjectsProvider =
    StateNotifierProvider<SubjectsNotifier, List<Subject>>(
  (ref) => SubjectsNotifier([])..fetchSubjects(),
);

class SubjectsNotifier extends StateNotifier<List<Subject>> {
  SubjectsNotifier(super.state);

  Future<void> fetchSubjects() async {
    //TODO: fetch subjects from repo
  }

  Future<void> deleteSubjects() async {
    //TODO: fetch subjects from repo
  }
}
