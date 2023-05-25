part of 'timer_state_notifier.dart';

class TimerState with TimerMixin {
  final int minuteDuration;

  TimerState({
    required this.minuteDuration,
  });

  @override
  int get timerDuration => minuteDuration * 60;
}
