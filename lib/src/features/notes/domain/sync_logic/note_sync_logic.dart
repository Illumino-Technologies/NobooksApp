import 'dart:async';
import 'dart:collection';

import 'package:nobook/src/features/notes/domain/sync_logic/note_sync_object.dart';
import 'package:nobook/src/features/notes/notes_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class NoteSyncLogic with BasicErrorHandlerMixin {
  final NoteLocalSourceInterface _localSource;
  final NoteNetworkSourceInterface _networkSource;
  final NoteSyncQueueSourceInterface _noteSyncQueueSource;
  Note _currentNote;
  final Queue<NoteSyncQueueObject> _syncQueue;

  Note get currentNote => _currentNote;

  NoteSyncLogic({
    required Note currentNote,
    NoteLocalSourceInterface? localSource,
    NoteNetworkSourceInterface? networkSource,
    NoteSyncQueueSourceInterface? noteSyncQueueSource,
  })  : _currentNote = currentNote,
        _localSource = localSource ?? NoteLocalSource(),
        _noteSyncQueueSource = noteSyncQueueSource ?? NoteSyncQueueSource(),
        _syncQueue = Queue<NoteSyncQueueObject>(),
        _syncQueueStream = const Stream<NoteDocument>.empty(),
        _networkSource = networkSource ?? NoteNetworkSource() {}

  Queue<NoteSyncQueueObject> get syncQueue =>
      Queue<NoteSyncQueueObject>.from(_syncQueue);

  final Stream<Note> _syncQueueStream;

  late final StreamSubscription<Note> _syncQueueSubscription =
      _syncQueueStream.listen(
    noteQueueListener,
  );

  Future<void> noteQueueListener(Note event) => handleError(
        _noteQueueListener(event),
      );

  Future<void> _noteQueueListener(Note event) async {}

  Future<void> _noteQueueErrorHandler(
    Failure failure,
    Note note,
  ) async {
    final NoteSyncQueueObject object = NoteSyncQueueObject(note: note);
    try {
      _currentNote = _currentNote.copyWith(noteBody: note.noteBody);
      await _localSource.storeNote(currentNote);
    } on Failure catch (failure, stackTrace) {
      if (failure.message == ErrorMessages.localNoteSyncFailure) {
        addToStaticQueue(object, NoteSyncError.local);
      }
      if (failure.message == ErrorMessages.networkNoteSyncFailure) {
        addToStaticQueue(object, NoteSyncError.network);
      }
    }
  }

  void addToStaticQueue(
    NoteSyncQueueObject noteSyncQueueObject,
    NoteSyncError error,
  ) {
    noteSyncQueueObject = noteSyncQueueObject.copyWith(errorReason: error);

    _syncQueue.removeWhere((element) => element.errorReason == error);

    _syncQueue.add(noteSyncQueueObject);
  }

  void _onResume() {}

  void _onPause() {}

  void _onListen() {}

  FutureOr<void> _onCancel() {}

  void dispose() {
    _syncQueueSubscription.cancel();
  }
}
