import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin StateCrudMixin<T> on StateNotifier<T?> {
  T? get readData => state;

  void createData(T data) {
    state = data;
  }

  void deleteData() {
    state = null;
  }
}
