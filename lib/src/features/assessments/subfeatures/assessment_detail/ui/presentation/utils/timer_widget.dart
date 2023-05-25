import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/assessments/subfeatures/assessment_detail/ui/state_mgmt/timer_state/timer_state_notifier.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

class AssessmentTimerWidget extends ConsumerStatefulWidget {
  const AssessmentTimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AssessmentTimerWidgetState();
}

class _AssessmentTimerWidgetState extends ConsumerState<AssessmentTimerWidget> {
  @override
  Widget build(BuildContext context) {
    return TimerWidget(
      timer: ref.read(AssessmentTimerStateNotifier.provider!.notifier).stream,
      timerDuration: ref.read(AssessmentTimerStateNotifier.provider!),
      leadingText: '',
      textStyle: TextStyles.subHeading.asSemibold.withColor(AppColors.blue500),
    );
  }
}
