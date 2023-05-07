import 'package:dio/dio.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/global/data/data_barrel.dart';

part 'assessment_source_interface.dart';

class AssignmentSource
    with DioErrorHandlerMixin
    implements AssessmentSourceInterface {
  final Dio _client;

  AssignmentSource({
    NetworkApi? api,
  }) : _client = api?.client ?? NetworkApi().client;

  @override
  Future<List<Assessment>> fetchAssessments(AssessmentType type) => handleError(
        _fetchAssessments(type),
      );

  Future<List<Assessment>> _fetchAssessments(AssessmentType type) async {
    final Response response = await _client.get(
      type.apiPath,
    );
  }

  @override
  Future<void> submitAssessment(
    Assessment assessment, {
    required AssessmentType type,
  }) {
    // TODO: implement submitAssessment
    throw UnimplementedError();
  }

  List<Assessment> _parseAssessmentsFromReponse(Response response) {
    final data = response.data as List;
    return data.map<Assessment>((e) => Assessment.fromMap(e)).toList();
  }
}
