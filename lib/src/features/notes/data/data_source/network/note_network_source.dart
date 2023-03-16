import 'dart:async';

import 'package:nobook/src/features/notes/model/note/note.dart';

part 'note_network_source_interface.dart';

class NoteNetworkSource implements NoteNetworkSourceInterface {
  @override
  Future<void> deleteNote() {
    // TODO: implement deleteNoteDocument
    throw UnimplementedError();
  }

  @override
  Future<Note> fetchOnlineNotes() {
    // TODO: implement fetchOnlineNotes
    throw UnimplementedError();
  }

  @override
  Future<void> storeNote(Note noteDocument) {
    // TODO: implement storeNoteDocument
    throw UnimplementedError();
  }
}
