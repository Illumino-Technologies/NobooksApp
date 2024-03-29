import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<AssessmentTimerStateNotifier, Duration>? _provider;

class AssessmentTimerStateNotifier extends StateNotifier<Duration> {
  final Duration initialDuration;
  Timer? _timer;

  bool get isOngoing => _timer?.isActive ?? false;

  AssessmentTimerStateNotifier({
    required int minuteDuration,
  })  : initialDuration = Duration(minutes: minuteDuration),
        super(Duration(minutes: minuteDuration));

  static StateNotifierProvider<AssessmentTimerStateNotifier, Duration>
      get requireProvider => _provider!;

  static StateNotifierProvider<AssessmentTimerStateNotifier, Duration>?
      get provider => _provider;

  static void refreshNotifier(
    int minuteDuration, {
    bool sureToRefresh = false,
  }) {
    if (!sureToRefresh) return;
    _provider = StateNotifierProvider<AssessmentTimerStateNotifier, Duration>(
      (ref) =>
          AssessmentTimerStateNotifier(minuteDuration: minuteDuration)..start(),
    );
  }

  void start() {
    if (!(_timer?.isActive ?? false)) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (state > Duration.zero) {
          state = state - const Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _provider = null;
    super.dispose();
  }
}
