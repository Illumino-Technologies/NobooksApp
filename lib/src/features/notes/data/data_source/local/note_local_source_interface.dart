part of 'note_local_source.dart';

abstract class NoteLocalSourceInterface {
  Future<void> deleteNote();

  Note? fetchOnlineNotes();

  Future<void> storeNote(Note noteDocument);
}
