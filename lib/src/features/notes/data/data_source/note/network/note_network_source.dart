import 'dart:async';

import 'package:nobook/src/features/notes/model/note/note.dart';
import 'package:nobook/src/global/data/apis/network/error_handler/dio_error_handler.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'note_network_source_interface.dart';

class NoteNetworkSource
    with DioErrorHandlerMixin
    implements NoteNetworkSourceInterface {
  @override
  Future<void> deleteNote(String id) {
    // TODO: implement deleteNoteDocument
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> fetchNotes() {
    // TODO: implement fetchOnlineNotes
    throw UnimplementedError();
  }

  @override
  Future<void> storeNote(Note noteDocument) => handleError(
        _storeNote(noteDocument),
        catcher: (failure) {
          throw failure.copyWith(message: ErrorMessages.localNoteSyncFailure);
          return;
        },
      );

  Future<void> _storeNote(Note noteDocument) {
    // TODO: implement storeNoteDocument
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNotes() {
    // TODO: implement deleteNotes
    throw UnimplementedError();
  }

  @override
  Future<Note> fetchNote(String id) {
    // TODO: implement fetchNote
    throw UnimplementedError();
  }

  @override
  Future<void> storeNotes(List<Note> noteDocument) {
    // TODO: implement storeNotes
    throw UnimplementedError();
  }
}
