import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/assessment_instructions.dart';

part 'custom/info_row.dart';

part 'custom/title_widget.dart';

class AssessmentPreviewPage extends ConsumerStatefulWidget {
  final Assessment assessment;

  const AssessmentPreviewPage({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AssessmentPreviewPageState();
}

class _AssessmentPreviewPageState extends ConsumerState<AssessmentPreviewPage> {
  @override
  void initState() {
    super.initState();
    AssessmentStageNotifier.refreshNotifier(assessment);
  }

  Assessment get assessment => widget.assessment;

  @override
  void dispose() {
    if (AssessmentTimerStateNotifier.provider != null) {
      ref.read(AssessmentTimerStateNotifier.provider!.notifier).dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          ref.read(AssessmentStageNotifier.provider).assessment!.submitted,
      child: Scaffold(
        body: Stack(
          children: [
            ScrollbarTheme(
              data: ScrollbarThemeData(
                trackBorderColor: MaterialStateProperty.all(Colors.transparent),
                trackColor: MaterialStateProperty.all(AppColors.grey100),
                thumbColor: MaterialStateProperty.all(AppColors.grey),
              ),
              child: Scrollbar(
                thickness: 16.w,
                radius: const Radius.circular(100),
                interactive: true,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.boxHeight,
                      Center(
                        child: Text(
                          'Instructions',
                          style: TextStyles.subHeading.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue500,
                          ),
                        ),
                      ),
                      40.boxHeight,
                      Center(
                        child: Column(
                          children: [
                            TitleWidget(assessment: assessment),
                            16.boxHeight,
                            Divider(
                              color: AppColors.neutral50,
                              thickness: 1.sp,
                              height: 1.sp,
                            ),
                            16.boxHeight,
                            InfoRow(assessment: assessment),
                          ],
                        ),
                      ),
                      48.boxHeight,
                      _AssessmentNoteItem(
                        title: '${assessment.type.longName} Instructions',
                        note: assessment.assessmentInstructions,
                      ),
                      12.boxHeight,
                      _AssessmentNoteItem(
                        title: '${assessment.type.longName} Conduct',
                        note: assessment.assessmentConduct,
                      ),
                      12.boxHeight,
                      _AssessmentNoteItem(
                        title: 'Student Declaration',
                        note: assessment.studentDeclaration,
                      ),
                      65.boxHeight,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(bottom: 32.h, right: 32.w),
              child: MaterialButton(
                highlightElevation: 0,
                focusElevation: 0,
                elevation: 0,
                color: AppColors.blue500,
                onPressed: switch (assessment.paperType) {
                  PaperType.multipleChoice => () => context.goNamed(
                        AppRoute.multipleChoiceAssessmentStage.name,
                        extra: assessment,
                      ),
                  PaperType.theory => () => context.goNamed(
                        AppRoute.theoryAssessmentQuestions.name,
                        extra: assessment,
                      ),
                  _ => throw (Failure(message: 'Invalid Paper Type')),
                },
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                child: Text(
                  'Proceed to ${assessment.type.longName.toLowerCase()}',
                  style: TextStyles.paragraph3.copyWith(
                    height: 1.333,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
