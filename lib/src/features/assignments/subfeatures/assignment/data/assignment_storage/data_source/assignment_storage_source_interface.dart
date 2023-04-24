part of 'assignment_storage_source.dart';

abstract class AssignmentStorageSourceInterface {
  Assignment? fetchAssignment(String id);

  List<Assignment>? fetchStoredAssignments();

  Future<void> storeAssignment(Assignment assignment);
}
