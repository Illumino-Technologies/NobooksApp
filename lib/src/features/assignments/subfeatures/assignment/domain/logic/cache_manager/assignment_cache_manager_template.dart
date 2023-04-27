part of 'assignment_cache_manager.dart';

abstract class AssignmentCacheManagerInterface {
  Assignment? fetchStoredAssignment(String id);

  List<Assignment>? fetchStoredAssignments();

  Future<void> storeAssignment(Assignment assignment);

  Future<void> deleteAssignment(String id);

  Future<void> clearAssignments();
}
