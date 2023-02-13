import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin AsyncStateCrudMixin<T> on Cubit<T?> {
  T? get readData => state;

  @mustCallSuper
  Future<void> createData(T data) async {
    emit(data);
  }

  @mustCallSuper
  Future<void> deleteData() async {
    emit(null);
  }
}
