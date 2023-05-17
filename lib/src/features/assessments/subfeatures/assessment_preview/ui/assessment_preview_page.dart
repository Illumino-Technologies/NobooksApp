import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/domain/logics/school_manager/school_notifier.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

part 'custom/assessment_conduct.dart';

part 'custom/assessment_instructions.dart';

part 'custom/info_row.dart';

part 'custom/student_declaration.dart';

part 'custom/title_widget.dart';

class AssessmentPreviewPage extends StatelessWidget {
  final Assessment assessment;

  const AssessmentPreviewPage({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          32.boxHeight,
          _TitleWidget(assessment: assessment),
          16.boxHeight,
          Divider(
            color: AppColors.neutral50,
            thickness: 1.sp,
            height: 1.sp,
          ),
          16.boxHeight,
          _InfoRow(assessment: assessment),
          48.boxHeight,
          Align(
            alignment: Alignment.topLeft,
            child: _AssessmentInstructions(assessment: assessment),
          ),
        ],
      ),
    );
  }
}
