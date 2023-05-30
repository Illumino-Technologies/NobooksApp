import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/assessment_operation_item.dart';

part 'custom/multiple_choice_stage_view.dart';

part 'custom/option_view.dart';

part 'custom/question_view.dart';

class MultipleChoiceAssessmentStagePage extends ConsumerStatefulWidget {
  final Assessment assessment;

  const MultipleChoiceAssessmentStagePage({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AssessmentStagePageState();
}

class _AssessmentStagePageState
    extends ConsumerState<MultipleChoiceAssessmentStagePage> {
  late final Assessment assessment = widget.assessment;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AssessmentTimerStateNotifier.refreshNotifier(
      assessment.duration,
      sureToRefresh: AssessmentTimerStateNotifier.provider == null
          ? true
          : !ref.read(AssessmentTimerStateNotifier.provider!.notifier).isActive,
    );

    manualListenerSubscription = ref.listenManual(
      AssessmentTimerStateNotifier.requireProvider.select(
        (value) => value.inSeconds,
      ),
      timerListener,
    );
  }

  late final ProviderSubscription<int> manualListenerSubscription;

  void timerListener(
    int? previousSecondDuration,
    int secondDuration,
  ) {
    final int assessmentDuration = assessment.duration * 60;
    if (secondDuration >= (assessmentDuration - 1)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.goNamed(
          AppRoute.assessmentReview.name,
          extra: ref.read(AssessmentStageNotifier.provider).assessment!,
        );
      });
    }
  }

  @override
  void dispose() {
    manualListenerSubscription.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              32.boxHeight,
              Row(
                children: [
                  const AssessmentTimerWidget(),
                  const Spacer(),
                  AssessmentNavigatorBar(
                    assessment: widget.assessment,
                    page: NavigatorBarPage.multipleChoiceQuestions,
                  ),
                  const Spacer(),
                  Text(
                    'Multiple choice',
                    style: TextStyles.subHeading.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue500,
                    ),
                  ),
                ],
              ),
              32.boxHeight,
              Row(
                children: [
                  Text(
                    assessment.subject.name,
                    style: TextStyles.headline4.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    UtilFunctions.formatLongDate(DateTime.now()),
                    style: TextStyles.footer.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.neutral400,
                    ),
                  ),
                ],
              ),
              24.boxHeight,
              Expanded(
                child: MultipleChoiceView(
                  scrollController: _scrollController,
                  assessment: assessment,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
