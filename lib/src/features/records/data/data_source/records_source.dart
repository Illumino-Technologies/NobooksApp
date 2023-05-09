import 'package:dio/dio.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/utils/constants/values/paths/api_paths.dart';

part 'records_source_interface.dart';

class RecordsSource
    with DioErrorHandlerMixin, NetworkUtilMixin
    implements RecordsSourceInterface {
  final Dio _client;

  RecordsSource({
    required NetworkApi? api,
  }) : _client = api?.client ?? NetworkApi().client;

  @override
  Future<List<Record>> fetchRecords() => handleError(_fetchRecords());

  Future<List<Record>> _fetchRecords() async {
    final Response response = await _client.get(ApiPaths.login, );



  }
}
