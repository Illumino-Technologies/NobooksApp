import 'package:flutter/material.dart' hide ListenableBuilder;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/assignments/subfeatures/assignment/ui/view/custom/custom_scrollable/multi_point_scroll_view.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/assessment_selector.dart';

part 'custom/question_view.dart';

part 'custom/questions_page_view.dart';

part 'custom/theory_assessment_operation_item.dart';

part 'custom/theory_assessment_operation_leaf_item.dart';

typedef OperationIndices = ({int operationIndex, int? subIndex});

class TheoryStagePage extends StatefulWidget {
  final Assessment assessment;
  final int operationIndex;
  final int? subOperationIndex;

  const TheoryStagePage({
    Key? key,
    required this.assessment,
    required this.operationIndex,
    this.subOperationIndex,
  }) : super(key: key);

  @override
  State<TheoryStagePage> createState() => _TheoryStagePageState();
}

class _TheoryStagePageState extends State<TheoryStagePage> {
  late final Assessment assessment = widget.assessment;
  late final int operationIndex = widget.operationIndex;
  late final int? subOperationIndex = widget.subOperationIndex;

  @override
  Widget build(BuildContext context) {
    final List<TheoryAssessmentOperation> operations =
        assessment.assessments.cast();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            children: [
              24.boxHeight,
              24.boxHeight,
              24.boxHeight,
              Expanded(
                child: _QuestionPageView(
                  assessment: assessment,
                  initialIndices: (
                    operationIndex: operationIndex,
                    subIndex: subOperationIndex,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// theory assessment page view
// theory assessment operation item
// theory assessment operation leaf item
