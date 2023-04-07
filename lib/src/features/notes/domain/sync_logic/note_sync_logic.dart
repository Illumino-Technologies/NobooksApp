import 'dart:async';
import 'dart:collection';

import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/notes_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'note_sync_logic_interface.dart';

part 'note_sync_object.dart';

class NoteSyncLogic
    with BasicErrorHandlerMixin
    implements NoteSyncLogicInterface {
  final NoteLocalSourceInterface _localSource;

  // final NoteNetworkSourceInterface _networkSource;
  final NoteLocalSourceInterface _networkSource;
  final NoteSyncQueueSourceInterface _noteSyncQueueSource;
  Note _currentNote;
  final Queue<NoteSyncQueueObject> _syncQueue;

  Note get currentNote => _currentNote;

  NoteSyncLogic({
    required Note currentNote,
    NoteLocalSourceInterface? localSource,
    NoteLocalSourceInterface? networkSource,
    // NoteNetworkSourceInterface? networkSource,
    NoteSyncQueueSourceInterface? noteSyncQueueSource,
  })  : _currentNote = currentNote,
        _localSource = localSource ?? NoteLocalSource(),
        _noteSyncQueueSource = noteSyncQueueSource ?? NoteSyncQueueSource(),
        _syncQueue = Queue<NoteSyncQueueObject>(),
        _networkSource = networkSource ?? NoteLocalSource() {
    _fetchQueueAndRetry();
  }

  Queue<NoteSyncQueueObject> get syncQueue =>
      Queue<NoteSyncQueueObject>.from(_syncQueue);

  @override
  Future<void> syncNote(Note note) => handleError(
        _storeNote(note),
      );

  @override
  Future<Note?> fetchStoredNote() => handleError(_fetchStoredNote());

  Future<Note?> _fetchStoredNote() async {
    //TODO: implement network fetch
    final Note? storedNote = _localSource.fetchNote(currentNote.id);
    return storedNote;
  }

  Future<void> _storeNote(
    Note note,
  ) async {
    NoteSyncQueueObject object = NoteSyncQueueObject(note: note);
    try {
      _currentNote = _currentNote.copyWith(noteBody: note.noteBody);

      await _storeNoteLocally(currentNote);
      object = object.copyWith(status: NoteSyncStatus.localSynced);

      await _storeNoteOnNetwork(currentNote);
      object = object.copyWith(status: NoteSyncStatus.networkSynced);
    } on Failure catch (failure) {
      if (failure.message == ErrorMessages.localNoteSyncFailure) {
        _addToQueue(object, NoteSyncError.local);
      } else if (failure.message == ErrorMessages.networkNoteSyncFailure) {
        _addToQueue(object, NoteSyncError.network);
      } else {
        _addToQueue(object, NoteSyncError.bothLocalAndNetwork);
      }
      rethrow;
    }
  }

  Future<void> _fetchQueueAndRetry() async {
    _syncQueue.clear();

    final Queue<NoteSyncQueueObject> queue = _noteSyncQueueSource.fetchQueue(
      currentNote.id,
    );

    if (queue.isEmpty) return;

    _syncQueue.addAll(queue);

    await _retryStoringNotesFromQueue();

    await _noteSyncQueueSource.clearQueue(currentNote.id);
  }

  Future<void> _retryStoringNotesFromQueue() async {
    final Queue<NoteSyncQueueObject> locallyFailedNotes = Queue.from(
      _syncQueue.where((element) {
        return element.errorReason == NoteSyncError.local;
      }),
    );

    final Queue<NoteSyncQueueObject> networkFailedNotes = Queue.from(
      _syncQueue.where((element) {
        return element.errorReason == NoteSyncError.local;
      }),
    );
    final Queue<NoteSyncQueueObject> failedNotes = Queue.from(
      _syncQueue.where((element) {
        return element.errorReason == NoteSyncError.bothLocalAndNetwork;
      }),
    );

    for (final NoteSyncQueueObject object in locallyFailedNotes) {
      await _storeNoteLocally(object.note);
      _syncQueue.remove(object);
    }
    for (final NoteSyncQueueObject object in networkFailedNotes) {
      await _storeNoteOnNetwork(object.note);
      _syncQueue.remove(object);
    }
    for (final NoteSyncQueueObject object in failedNotes) {
      await _storeNote(object.note);
      _syncQueue.remove(object);
    }
  }

  void _addToQueue(
    NoteSyncQueueObject noteSyncQueueObject,
    NoteSyncError error,
  ) {
    noteSyncQueueObject = noteSyncQueueObject.copyWith(errorReason: error);

    _syncQueue.removeWhere((element) => element.errorReason == error);

    _syncQueue.add(noteSyncQueueObject);
  }

  Future<void> _saveQueue() async {
    if (_syncQueue.isEmpty) return;
    await _noteSyncQueueSource.storeQueue(currentNote.id, _syncQueue);
  }

  Future<void> _storeNoteLocally(Note note) async {
    await _localSource.storeNote(note);
  }

  Future<void> _storeNoteOnNetwork(Note note) async {
    await _networkSource.storeNote(note);
  }

  @override
  void dispose() {
    _saveQueue();
  }

  @override
  Future<void> clearNotes() async {
    await _localSource.deleteNote(currentNote.id);
    await _noteSyncQueueSource.clearQueue(currentNote.id);
  }
}
