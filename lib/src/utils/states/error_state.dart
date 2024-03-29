import 'package:nobook/src/utils/utils_barrel.dart';

abstract class ErrorState extends RiverpodState {
  final Failure failure;

  const ErrorState({
    required this.failure,
  });
}
