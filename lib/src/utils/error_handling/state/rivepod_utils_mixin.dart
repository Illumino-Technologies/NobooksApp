import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

mixin RiverpodUtilsMixin<State extends RiverpodStateWithStatus>
    on StateNotifier<State> {
  void notifyOnError(Failure error) {
    state = state.copyWith(error: error, loading: false, success: false);
  }

  void notifyLoading([nullifyError = true]) {
    state = state.copyWith(
      loading: true,
      success: false,
      error: nullifyError ? null : state.error,
    );
  }

  void notifySuccess([nullifyError = true]) {
    state = state.copyWith(
      success: true,
      loading: false,
      error: nullifyError ? null : state.error,
    );
  }
}
