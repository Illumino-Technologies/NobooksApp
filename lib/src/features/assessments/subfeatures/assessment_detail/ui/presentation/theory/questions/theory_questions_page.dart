import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/assessments_view.dart';

part 'custom/theory_assessment_leaf_widget.dart';

part 'custom/theory_assessment_widget.dart';

class TheoryQuestionsPage extends ConsumerStatefulWidget {
  final Assessment assessment;

  const TheoryQuestionsPage({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TheoryQuestionsPageState();
}

class _TheoryQuestionsPageState extends ConsumerState<TheoryQuestionsPage> {
  final ValueNotifier<int?> answerStageIndexNotifier = ValueNotifier<int?>(
    null,
  );

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
    if (secondDuration <= 1) {
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
    answerStageIndexNotifier.dispose();
    super.dispose();
  }

  late final Assessment assessment = widget.assessment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollbarWrapper(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            children: [
              40.boxHeight,
              Row(
                children: [
                  const AssessmentTimerWidget(),
                  const Spacer(),
                  AssessmentNavigatorBar(
                    assessment: assessment,
                    page: NavigatorBarPage.listOfQuestions,
                  ),
                  const Spacer(),
                  Text(
                    'Theory',
                    style: TextStyles.subHeading.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue500,
                    ),
                  ),
                ],
              ),
              40.boxHeight,
              Text(
                'Tap a question to start answering. Your answers will appear '
                'below each question after answering them.',
                style: TextStyles.headline6.copyWith(
                  fontSize: 16.sp,
                  height: 1.5,
                  color: AppColors.neutral400,
                ),
              ),
              40.boxHeight,
              TitleWidget(assessment: assessment),
              16.boxHeight,
              Divider(
                height: 2.h,
                thickness: 2.h,
                color: AppColors.neutral50,
              ),
              16.boxHeight,
              InfoRow(assessment: assessment),
              Expanded(
                child: _AssessmentsView(assessment: assessment),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
