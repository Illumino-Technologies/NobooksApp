import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin AsyncStateCrudMixin<T> on StateNotifier<T?> {
  T? get readData => state;

  @mustCallSuper
  Future<void> createData(T data) async {
    state = data;
  }

  @mustCallSuper
  Future<void> deleteData() async {
    state = null;
  }
}
