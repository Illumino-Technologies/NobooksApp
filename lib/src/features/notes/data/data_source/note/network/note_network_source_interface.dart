part of 'note_network_source.dart';

abstract class NoteNetworkSourceInterface {
  Future<void> deleteNotes();

  Future<void> deleteNote(String id);

  Future<List<Note>> fetchNotes();

  Future<Note> fetchNote(String id);

  Future<void> storeNotes(List<Note> noteDocument);

  Future<void> storeNote(Note noteDocument);
}
