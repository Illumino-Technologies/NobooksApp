import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/_auth/auth_feature_barrel.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'request_login_state.dart';

StateNotifierProvider<RequestLoginStateNotifier, RequestLoginState>? _provider;

class RequestLoginStateNotifier extends StateNotifier<RequestLoginState>
    with BasicErrorHandlerMixin, RiverpodUtilsMixin {
  final AuthSourceInterface _authSource;
  final SchoolSourceInterface _schoolSource;

  RequestLoginStateNotifier({
    required AuthSourceInterface authSource,
    required SchoolSourceInterface schoolSource,
  })  : _authSource = authSource,
        _schoolSource = schoolSource,
        super(RequestLoginState());

  static StateNotifierProvider<RequestLoginStateNotifier, RequestLoginState>
      get provider {
    if (_provider == null) {
      throw Exception('LoginStateNotifier provider is not initialized');
    }
    return _provider!;
  }

  static void initProvider() {
    _provider =
        StateNotifierProvider<RequestLoginStateNotifier, RequestLoginState>(
      (ref) => RequestLoginStateNotifier(
        authSource: FakeAuthSource(),
        schoolSource: const FakeSchoolSource(),
      ),
    );
  }

  static void disposeProvider() {
    _provider = null;
  }

  Future<void> fetchSchoolsByQuery({
    required String searchQuery,
  }) =>
      handleError(_fetchSchoolsByQuery(searchQuery));

  Future<void> _fetchSchoolsByQuery(String searchQuery) async {
    notifyLoading();
    final List<School> schools = await _schoolSource.fetchSchoolsByQuery(
      searchQuery: searchQuery,
    );
    notifySuccess(newState: state.copyWith(schools: schools));
  }

  Future<void> requestLogin({
    required String schoolID,
    required String fullName,
    required String email,
  }) =>
      handleError(_requestLogin(schoolID, fullName, email));

  Future<void> _requestLogin(
    String schoolID,
    String fullName,
    String email,
  ) async {
    notifyLoading();
    await _authSource.requestLoginDetails(
      schoolId: schoolID,
      fullName: fullName,
      email: email,
    );
    notifySuccess();
  }
}
