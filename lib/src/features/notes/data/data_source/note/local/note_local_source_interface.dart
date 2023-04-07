part of 'note_local_source.dart';

abstract class NoteLocalSourceInterface {
  Future<void> deleteNote(String id);

  Future<void> deleteAllNotes();

  Note? fetchNote(String id);

  List<Note> fetchAllNotes();

  Future<void> storeNote(Note note);

  Future<void> storeNotes(List<Note> notes);
}
