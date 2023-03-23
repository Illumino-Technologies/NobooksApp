import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/data/notes_data_barrel.dart';

part 'note_repo_interface.dart';

class NoteRepository implements NoteRepoInterface {
  final NoteLocalSourceInterface _localSource;
  final NoteNetworkSourceInterface _networkSource;

  NoteRepository({
    NoteLocalSourceInterface? localSource,
    NoteNetworkSourceInterface? networkSource,
  })  : _localSource = localSource ?? NoteLocalSource(),
        _networkSource = networkSource ?? NoteNetworkSource();


  @override
  Future<void> deleteAllNotes(data) {
    // TODO: implement deleteAllNotes
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNote(String id) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<Note> fetchNote(String id) {
    // TODO: implement fetchNote
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> fetchNotes(String id) {
    // TODO: implement fetchNotes
    throw UnimplementedError();
  }

  @override
  Future<void> postNote(Note note) {
    // TODO: implement postNote
    throw UnimplementedError();
  }

  @override
  Future<void> postNotes(List<Note> note) {
    // TODO: implement postNotes
    throw UnimplementedError();
  }
}
