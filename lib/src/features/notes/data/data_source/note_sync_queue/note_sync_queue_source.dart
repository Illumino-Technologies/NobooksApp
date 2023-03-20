import 'dart:collection';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:nobook/src/features/notes/notes_barrel.dart';
import 'package:nobook/src/global/data/apis/storage/error_handler/hive_error_handler.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'note_sync_queue_source_interface.dart';

class NoteSyncQueueSource
    with HiveErrorHandlerMixin
    implements NoteSyncQueueSourceInterface {
  final Box<Iterable> _box;

  NoteSyncQueueSource({
    Box<Iterable<Map<String, dynamic>>>? box,
  }) : _box = box ??
            Hive.box<Iterable>(
              StorageKey.noteSyncQueue.box,
            );

  @override
  Future<void> clearAllQueue() => handleError(_clearAllQueue());

  Future<void> _clearAllQueue() async {
    await _box.clear();
  }

  @override
  Future<void> clearQueue(String id) => handleError(_clearQueue(id));

  Future<void> _clearQueue(String id) async {
    await _box.delete(id);
  }

  @override
  Queue<NoteSyncQueueObject> fetchQueue(String id) => handleSyncError(
        _fetchQueue(id),
      );

  Queue<NoteSyncQueueObject> _fetchQueue(String id) {
    final Queue<NoteSyncQueueObject> queue = Queue();

    final Iterable<Map<String, dynamic>> data = _box.get(id)?.map((e) {
          return e.cast<String, dynamic>();
        }) ??
        const Iterable.empty();

    if (data.isEmpty) return queue;

    for (final Map<String, dynamic> map in data) {
      queue.add(NoteSyncQueueObject.fromMap(map));
    }
    return queue;
  }

  @override
  Future<void> storeQueue(String id, Queue<NoteSyncQueueObject> queue) =>
      handleError(_storeQueue(id, queue));

  Future<void> _storeQueue(String id, Queue<NoteSyncQueueObject> queue) async {
    final Iterable<Map<String, dynamic>> data = queue.map<Map<String, dynamic>>(
      (e) => e.toMap(),
    );

    await _box.put(id, data);
  }
}
