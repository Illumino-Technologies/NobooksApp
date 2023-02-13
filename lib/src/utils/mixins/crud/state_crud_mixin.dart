import 'package:flutter_bloc/flutter_bloc.dart';

mixin StateCrudMixin<T> on Cubit<T?> {
  T? get readData => state;

  void createData(T data) {
    emit(data);
  }

  void deleteData() {
    emit(null);
  }
}
