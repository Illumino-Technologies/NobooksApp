import 'package:dio/dio.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/global/domain/fakes/fakes_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'class_source_interface.dart';

part 'fake_class_source.dart';

class ClassSource
    with DioErrorHandlerMixin, NetworkUtilMixin
    implements ClassSourceInterface {
  final Dio _client;

  ClassSource({
    NetworkApi? api,
  }) : _client = api?.client ?? NetworkApi().client;

  @override
  Future<Class> fetchStudentClass(String studentId) => handleError(
        _fetchStudentClass(studentId),
      );

  Future<Class> _fetchStudentClass(String studentId) async {
    //TODO: check should manually add token
    final Response response = await _client.get(ApiPaths.class_(studentId));

    throwOnFailed(response);

    return Class.fromMap(
      ((response.data['data'] ?? response.data) as Map).cast(),
    );
  }

  @override
  Future<List<Class>> fetchStudentClasses(String studentId) => handleError(
        _fetchStudentClasses(studentId),
      );

  Future<List<Class>> _fetchStudentClasses(String studentId) async {
    //TODO: check should manually add token
    final Response response = await _client.get(ApiPaths.classes(studentId));

    throwOnFailed(response);

    return (dataOf(response) as List)
        .map((e) => Class.fromMap((e as Map).cast()))
        .toList();
  }
}
