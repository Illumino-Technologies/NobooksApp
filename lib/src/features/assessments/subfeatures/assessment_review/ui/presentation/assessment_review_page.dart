import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/question_item.dart';

part 'custom/questions_view.dart';

part 'custom/review_view.dart';

part 'custom/top_ribbon.dart';

class AssessmentReviewPage extends ConsumerStatefulWidget {
  final Assessment assessment;

  const AssessmentReviewPage({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AssessmentReviewPageState();
}

class _AssessmentReviewPageState extends ConsumerState<AssessmentReviewPage> {
  @override
  Widget build(BuildContext context) {

    final Widget child = Scaffold(
      body: SafeArea(
        child: ScrollbarWrapper(
          child: _ReviewView(
            assessment: widget.assessment,
          ),
        ),
      ),
    );

    return ref.read(AssessmentTimerStateNotifier.provider!.notifier).isActive
        ? child
        : WillPopScope(onWillPop: () async => false, child: child);
  }
}
