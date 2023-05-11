import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assignments/subfeatures/assignment/ui/view/custom/custom_scrollable/multi_point_scroll_view.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/answer_view.dart';

part 'custom/assignment_page_view.dart';

part 'custom/question_answer_view.dart';

part 'custom/question_indicator.dart';

part 'custom/question_view.dart';

class AssignmentScreen extends ConsumerStatefulWidget {
  final Assignment assignment;

  const AssignmentScreen({
    Key? key,
    required this.assignment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends ConsumerState<AssignmentScreen> {
  @override
  void initState() {
    super.initState();
    ref
        .read(AssignmentStateNotifier.provider.notifier)
        .resetAssignmentProvider();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(AssignmentStateNotifier.provider.notifier).initializeAssignment(
          widget.assignment,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AssignmentPageView(
        assignment: widget.assignment,
      ),
    );
  }
}
