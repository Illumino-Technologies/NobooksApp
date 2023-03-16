part of 'note_network_source.dart';

abstract class NoteNetworkSourceInterface {
  Future<void> deleteNote();

  FutureOr<Note> fetchOnlineNotes();

  Future<void> storeNote(Note noteDocument);
}
