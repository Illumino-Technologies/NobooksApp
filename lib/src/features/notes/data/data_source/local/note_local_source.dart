import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:nobook/src/features/notes/model/note/note.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'note_local_source_interface.dart';

class NoteLocalSource
    with HiveErrorHandlerMixin
    implements NoteLocalSourceInterface {
  final Box<Map<String, dynamic>> _box;

  NoteLocalSource({
    Box<Map<String, dynamic>>? box,
  }) : _box = box ?? Hive.box<Map<String, dynamic>>(StorageKey.note.box);

  @override
  Future<void> deleteNote() => handleError(_deleteNote());

  Future<void> _deleteNote() async {}

  @override
  Note? fetchOnlineNotes() => handleSyncError(_fetchOnlineNotes());

  Note? _fetchOnlineNotes() {
    final Map<String, dynamic>? data = _box.get(StorageKey.note.key);

    if (data == null) return null;

    final Note note = Note.fromMap(data);
    return note;
  }

  @override
  Future<void> storeNote(Note note) => handleError(
        _storeNote(note),
      );

  Future<void> _storeNote(Note note) async {
    _box.put(StorageKey.note.key, note.toMap());
  }
}
