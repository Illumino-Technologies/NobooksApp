enum StorageKey {
  assignment,
  user,
  note,
  noteSyncQueue,
  ;

  const StorageKey();

  String get key => '$name-key';

  String get box => '$name-box';
}
