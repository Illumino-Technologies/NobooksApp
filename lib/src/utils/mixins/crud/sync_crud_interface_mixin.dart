mixin SyncCrudInterfaceMixin<Data> {
  Data? fetch();

  Future<void> create(Data data);

  Future<void> update(Data newData);

  Future<void> delete();
}
