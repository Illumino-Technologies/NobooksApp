part of 'note_sync_logic.dart';

enum NoteSyncStatus {
  noneSynced,
  localSynced,
  networkSynced,
  syncCompleted;

  const NoteSyncStatus();
}

enum NoteSyncError {
  local,
  network,
  bothLocalAndNetwork,
  ;

  const NoteSyncError();
}

class NoteSyncQueueObject {
  final Note note;
  final NoteSyncStatus status;
  final NoteSyncError? _errorReason;

  NoteSyncError? get errorReason => _errorReason;

  const NoteSyncQueueObject({
    required this.note,
    this.status = NoteSyncStatus.noneSynced,
    NoteSyncError? errorReason,
  }) : _errorReason =
            status == NoteSyncStatus.syncCompleted ? null : errorReason;

  NoteSyncQueueObject copyWith({
    final Note? note,
    NoteSyncStatus? status,
    NoteSyncError? errorReason,
  }) {
    switch (errorReason) {
      case NoteSyncError.local:
        {
          if (_errorReason == NoteSyncError.network) {
            errorReason = NoteSyncError.bothLocalAndNetwork;
          }
          break;
        }
      case NoteSyncError.network:
        {
          if (_errorReason == NoteSyncError.local) {
            errorReason = NoteSyncError.bothLocalAndNetwork;
          }
          break;
        }
      default:
        break;
    }

    switch (status) {
      case NoteSyncStatus.localSynced:
        if (this.status == NoteSyncStatus.networkSynced) {
          status = NoteSyncStatus.syncCompleted;
          break;
        }

      case NoteSyncStatus.networkSynced:
        if (this.status == NoteSyncStatus.localSynced) {
          status = NoteSyncStatus.syncCompleted;
          break;
        }
      case null:
      case NoteSyncStatus.noneSynced:
      case NoteSyncStatus.syncCompleted:
        break;
    }

    return NoteSyncQueueObject(
      note: note ?? this.note,
      status: status ?? this.status,
      errorReason: errorReason ?? _errorReason,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'status': status.index,
      'errorReason': _errorReason?.index,
    };
  }

  factory NoteSyncQueueObject.fromMap(Map<String, dynamic> map) {
    return NoteSyncQueueObject(
      note: map['note'],
      status: NoteSyncStatus.values[(map['status'] as int)],
      errorReason: map['errorReason'] == null
          ? null
          : NoteSyncError.values[(map['errorReason'] as int)],
    );
  }
}
