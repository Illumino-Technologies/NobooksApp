
import 'package:dio/dio.dart';
import 'package:nobook/src/features/records/records_barrel.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'fake_records_source.dart';

part 'records_source_interface.dart';

class RecordsSource
    with DioErrorHandlerMixin, NetworkUtilMixin
    implements RecordsSourceInterface {
  final Dio _client;

  RecordsSource({
    NetworkApi? api,
  }) : _client = api?.client ?? NetworkApi().client;

  @override
  Future<Map<Class, List<Grade>>> fetchAllGrades() => handleError(
        _fetchRecords(),
      );

  Future<Map<Class, List<Grade>>> _fetchRecords() async {
    final Response response = await _client.get(
      ApiPaths.records,
      options: optionsWithToken,
    );

    throwOnFailed(response);

    return _parseClassGrade(response);
  }

  @override
  Future<List<Grade>> fetchGradesForClass(Class class_) => handleError(
        _fetchGradesForClass(class_),
      );

  Future<List<Grade>> _fetchGradesForClass(Class class_) async {
    final Response response = await _client.get(
      ApiPaths.recordsForClass(class_.id),
      options: optionsWithToken,
    );

    throwOnFailed(response);

    return _parseGradesFrom(response);
  }

  List<Grade> _parseGradesFrom(Response<dynamic> response) {
    return (response.data is List
            ? response.data
            : (response.data as Map)['data'])
        .cast<Map>()
        .map((e) => Grade.fromMap(e.cast()))
        .toList();
  }

  Map<Class, List<Grade>> _parseClassGrade(Response<dynamic> response) {
    Map<Map, List> data =
        ((response.data as Map)['data'] ?? (response.data as Map)).cast();

    return data.map<Class, List<Grade>>(
      (key, value) => MapEntry(
        Class.fromMap(key.cast()),
        value.cast<Map>().map<Grade>((e) => Grade.fromMap(e.cast())).toList(),
      ),
    );
  }
}
