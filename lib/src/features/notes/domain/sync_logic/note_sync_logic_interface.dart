part of 'note_sync_logic.dart';

abstract class NoteSyncLogicInterface {
  Future<void> syncNote(Note note);

  Future<Note?> fetchStoredNote();
}