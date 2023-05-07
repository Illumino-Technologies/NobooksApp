import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'assessment_source_interface.dart';

class AssignmentSource
    with DioErrorHandlerMixin, NetworkUtilMixin
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
      //TODO: check if should modify apiPath
      type.apiPath,
      options: optionsWithToken,
    );

    throwOnFailed(response);

    return _parseAssessmentsFromResponse(response);
  }

  @override
  Future<void> submitAssessment(
    Assessment assessment, {
    required AssessmentType type,
  }) =>
      handleError(_submitAssessment(assessment, type: type));

  Future<void> _submitAssessment(
    Assessment assessment, {
    required AssessmentType type,
  }) async {
    final Response response = await _client.post(
      //TODO: check if should modify apiPath
      type.apiPath,
      data: jsonEncode(assessment.toMap()),
      options: optionsWithToken,
    );

    throwOnFailed(response);
  }

  List<Assessment> _parseAssessmentsFromResponse(Response response) {
    final data = response.data as List;
    return data.map<Assessment>((e) => Assessment.fromMap(e)).toList();
  }
}
