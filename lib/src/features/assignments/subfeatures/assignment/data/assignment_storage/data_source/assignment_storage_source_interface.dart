part of 'assignment_storage_source.dart';

abstract class AssignmentStorageSourceInterface {
  Assignment? fetchAssignment(String id);

  List<Assignment>? fetchStoredAssignments();

  Future<void> storeAssignment(Assignment assignment);

  Future<void> deleteAssignment(String id);

  Future<void> clearAssignments();
}
