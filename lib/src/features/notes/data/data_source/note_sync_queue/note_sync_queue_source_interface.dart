part of 'note_sync_queue_source.dart';

abstract class NoteSyncQueueSourceInterface {
  Queue<NoteSyncQueueObject> fetchQueue(String id);

  Future<void> storeQueue(String id, Queue<NoteSyncQueueObject> queue);

  Future<void> clearQueue(String id);

  Future<void> clearAllQueue();
}
