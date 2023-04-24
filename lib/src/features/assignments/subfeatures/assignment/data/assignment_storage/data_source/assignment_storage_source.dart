import 'package:hive_flutter/hive_flutter.dart';
import 'package:nobook/src/features/assignments/assignments_barrel.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/utils/constants/constants_barrel.dart';

part 'assignment_storage_source_interface.dart';

class AssignmentStorageSource
    with HiveErrorHandlerMixin
    implements AssignmentStorageSourceInterface {
  final Box<Map> _box;

  AssignmentStorageSource({
    Box<Map>? box,
  }) : _box = Hive.box<Map>(StorageKey.assignment.box);

  @override
  Assignment? fetchAssignment(String id) => handleSyncError(
        _fetchAssignment(id),
      );

  Assignment? _fetchAssignment(String id) {
    final Map? rawAssignment = _box.get(id);
    if (rawAssignment == null) return null;
    return Assignment.fromMap(rawAssignment.cast());
  }

  @override
  List<Assignment>? fetchStoredAssignments() => handleSyncError(
        _fetchStoredAssignments(),
      );

  List<Assignment>? _fetchStoredAssignments() {
    final List<Assignment> assignments = [];
    final Iterable<Map> rawAssignments = _box.values;

    if (rawAssignments.isEmpty) return null;

    for (final dynamic rawAssignment in rawAssignments) {
      assignments.add(
        Assignment.fromMap(
          (rawAssignment as Map).cast(),
        ),
      );
    }
    return assignments;
  }

  @override
  Future<void> storeAssignment(Assignment assignment) => handleError(
        _storeAssignment(assignment),
      );

  Future<void> _storeAssignment(Assignment assignment) async {
    if (_box.containsKey(assignment.id)) {
      await _box.delete(assignment.id);
    }
    await _box.put(assignment.id, assignment.toMap());
  }
}
