enum StorageKey {
  user,
  settings,
  passcode,
  loginInfo;

  const StorageKey();

  String get key => '$name-key';

  String get box => '$name-box';
}
