part of 'records_source.dart';

abstract class RecordsSourceInterface {
  Future<List<Record>> fetchRecords();
}
