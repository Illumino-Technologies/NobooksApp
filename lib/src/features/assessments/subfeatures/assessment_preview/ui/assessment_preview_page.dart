import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/domain/logics/school_manager/school_notifier.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

part 'custom/assessment_instructions.dart';

part 'custom/info_row.dart';

part 'custom/title_widget.dart';

class AssessmentPreviewPage extends StatelessWidget {
  final Assessment assessment;

  const AssessmentPreviewPage({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    32.boxHeight,
                    Center(
                      child: Column(
                        children: [
                          _TitleWidget(assessment: assessment),
                          16.boxHeight,
                          Divider(
                            color: AppColors.neutral50,
                            thickness: 1.sp,
                            height: 1.sp,
                          ),
                          16.boxHeight,
                          _InfoRow(assessment: assessment),
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
            child: DenseButton(
              width: 241.w,
              height: 48.h,
              onPressed: () {
                context.pushReplacementNamed(
                  AppRoute.assessmentStage.name,
                  extra: assessment,
                );
              },
              child: Text(
                'Proceed to examination',
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
    );
  }
}
