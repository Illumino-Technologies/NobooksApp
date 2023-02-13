enum StorageKey {
  user(Map),
  settings(Map),
  passcode(String),
  loginInfo(Map);

  final Type type;

  const StorageKey(this.type);

  String get key => '$name-key';

  String get box => '$name-box';
}
