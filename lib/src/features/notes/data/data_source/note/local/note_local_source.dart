import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:nobook/src/features/notes/model/note/note.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'note_local_source_interface.dart';

class NoteLocalSource
    with HiveErrorHandlerMixin
    implements NoteLocalSourceInterface {
  final Box<Map> _box;

  NoteLocalSource({
    Box<Map<String, dynamic>>? box,
  }) : _box = box ?? Hive.box<Map>(StorageKey.note.box);

  @override
  Future<void> deleteNote(String id) => handleError(_deleteNote(id));

  Future<void> _deleteNote(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> deleteAllNotes() => handleError(_deleteAllNotes());

  Future<void> _deleteAllNotes() async {
    await _box.clear();
  }

  @override
  Note? fetchNote(String id) => handleSyncError(_fetchNote(id));

  Note? _fetchNote(String id) {
    final Map<String, dynamic>? data = _box.get(id)?.cast<String, dynamic>();

    if (data == null) return null;

    final Note note = Note.fromMap(data);
    return note;
  }

  @override
  List<Note> fetchAllNotes() => handleSyncError(_fetchAllNotes());

  List<Note> _fetchAllNotes() {
    final List<Map<String, dynamic>> data = _box.values.map((e) {
      return e.cast<String, dynamic>();
    }).toList();

    if (data.isNullOrEmpty) return [];

    final List<Note> notes = [];
    for (final Map<String, dynamic> noteData in data) {
      notes.add(Note.fromMap(noteData));
    }

    return notes;
  }

  @override
  Future<void> storeNote(Note note) => handleError(
        _storeNote(note),
        catcher: (failure) async => throw failure.copyWith(
          message: ErrorMessages.localNoteSyncFailure,
        ),
      );

  Future<void> _storeNote(Note note) async {
    await _box.put(note.id, note.toMap());
  }

  @override
  Future<void> storeNotes(List<Note> notes) => handleError(
        _storeNotes(notes),
      );

  Future<void> _storeNotes(List<Note> notes) async {
    await _box.putAll(
      Map<String, Map<String, dynamic>>.fromIterables(
        notes.map<String>((e) => e.id),
        notes.map<Map<String, dynamic>>((e) => e.toMap()),
      ),
    );
  }
}
