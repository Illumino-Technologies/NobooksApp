import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/error/domain/error_messages.dart';

mixin TokenErrorMixin {
  String fetchNonNullToken() {
    final String? token = TokenCubit.token;

    if (token == null) {
      throw (ErrorMessages.nullToken);
    }
    return token;
  }
}
