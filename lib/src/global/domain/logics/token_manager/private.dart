part of 'token_manager.dart';

class _TokenNotifier extends StateNotifier<String?>
    with StateCrudMixin<String> {
  _TokenNotifier() : super(null);

  @override
  String? get readData => state ?? TokenStorageSource().getUserToken();

  @override
  void createData(String data) {
    TokenStorageSource().storeToken(data);
    NetworkApi().changeTokenInHeaders(data);
    super.createData(data);
  }

  @override
  void deleteData() {
    TokenStorageSource().removeUserToken();
    super.deleteData();
  }
}
