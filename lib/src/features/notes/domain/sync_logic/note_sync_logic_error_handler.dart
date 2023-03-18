import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/domain/sync_logic/note_sync_object.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

typedef NoteSyncErrorFallback = Function(
  NoteSyncQueueObject syncObject,
  Failure failure,
);

mixin NoteSyncErrorHandler {
  Future<T> handleError<T>(
    Note note,
    Future<T> computation, {
    NoteSyncErrorFallback? localErrorFallback,
  }) async {
    try {
      return await computation;
    } catch (e, stackTrace) {
      late Failure failure;
      if (e is! Failure) {
        failure = Failure(message: '$e', stackTrace: stackTrace);
      } else {
        failure = e;
      }
    }
  }
}
