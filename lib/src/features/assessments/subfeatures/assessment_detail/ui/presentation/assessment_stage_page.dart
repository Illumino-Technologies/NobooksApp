import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/assessment_stage_view.dart';

class AssessmentStagePage extends ConsumerStatefulWidget {
  final Assessment assessment;

  const AssessmentStagePage({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AssessmentStagePageState();
}

class _AssessmentStagePageState extends ConsumerState<AssessmentStagePage> {
  late final Assessment assessment = widget.assessment;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AssessmentStageNotifier.refreshNotifier(assessment);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              children: [
                32.boxHeight,
                Row(
                  children: [
                    Container(
                      width: 82.w,
                      height: 24.h,
                      color: AppColors.blue500,
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      color: AppColors.blue500,
                      child: Text(
                        assessment.paperType.shortName,
                        style: TextStyles.paragraph3.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
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
                  child: switch (assessment.paperType) {
                    PaperType.multipleChoice => MultipleChoiceView(
                        scrollController: _scrollController,
                        assessment: assessment,
                      ),
                    PaperType.theory => TheoryStageView(assessment: assessment),
                    _ => Container(),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}