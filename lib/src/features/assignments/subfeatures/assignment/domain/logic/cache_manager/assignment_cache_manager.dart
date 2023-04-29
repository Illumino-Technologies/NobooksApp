//architecture

import 'package:nobook/src/features/assignments/subfeatures/assignment/data/assignment_storage/data_source/assignment_storage_source.dart';
import 'package:nobook/src/features/features_barrel.dart';

part 'assignment_cache_manager_template.dart';

class AssignmentsCacheManager implements AssignmentCacheManagerInterface {
  final AssignmentStorageSourceInterface _source;

  AssignmentsCacheManager({
    AssignmentStorageSourceInterface? source,
  }) : _source = source ?? AssignmentStorageSource();

  @override
  Assignment? fetchStoredAssignment(String id) {
    return _source.fetchAssignment(id);
  }

  @override
  List<Assignment>? fetchStoredAssignments() {
    return _source.fetchStoredAssignments();
  }

  @override
  Future<void> storeAssignment(Assignment assignment) async {
    await _source.storeAssignment(assignment);
  }

  @override
  Future<void> clearAssignments() async {
    await _source.clearAssignments();
  }

  @override
  Future<void> deleteAssignment(String id) async {
    await _source.deleteAssignment(id);
  }
}
