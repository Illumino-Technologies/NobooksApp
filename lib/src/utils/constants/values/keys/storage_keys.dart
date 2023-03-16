enum StorageKey {
  user,
  note,
  ;

  const StorageKey();

  String get key => '$name-key';

  String get box => '$name-box';
}
