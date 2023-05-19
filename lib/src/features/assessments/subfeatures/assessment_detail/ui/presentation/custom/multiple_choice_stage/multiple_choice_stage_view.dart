import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/mixins/drawing_mixin/intrinsic_canvas_size_mixin.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'assessment_operation_item.dart';

part 'option_view.dart';

part 'question_view.dart';

class MultipleChoiceView extends ConsumerWidget {
  final Assessment assessment;
  final ScrollController scrollController;

  const MultipleChoiceView({
    Key? key,
    required this.assessment,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.white,
      child: ListView.separated(
        controller: scrollController,
        itemCount: assessment.assessments.length,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        separatorBuilder: (context, index) => 64.boxHeight,
        itemBuilder: (context, index) => _MCQOperationItem(
          index: index,
          key: ValueKey(
            '${assessment.assessments[index].id} ${index + 1} ${assessment.assessments[index].answer}',
          ),
        ),
      ),
    );
  }
}
