import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/records/data/data_source/records_source.dart';
import 'package:nobook/src/features/records/records_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'state/records_state.dart';

class RecordsNotifier extends StateNotifier<RecordsState> {
  final RecordsSourceInterface _source;

  RecordsNotifier({
    RecordsSourceInterface? source,
  })  : _source = source ?? RecordsSource(),
        super(const RecordsState(classGrades: {}));


  Future<void> fetchAllGrades() async {

  }



}
