part of 'note_repository.dart';

abstract class NoteRepoInterface {
  Future<Note> fetchNote(String id);

  Future<List<Note>> fetchNotes(String id);

  Future<void> postNote(Note note);

  Future<void> postNotes(List<Note> note);

  Future<void> deleteAllNotes(dynamic data);

  Future<void> deleteNote(String id);
}
