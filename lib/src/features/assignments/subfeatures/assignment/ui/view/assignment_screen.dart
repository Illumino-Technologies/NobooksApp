import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assignments/subfeatures/assignment/ui/view/custom/custom_scrollable/multi_point_scroll_view.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'custom/answer_view.dart';

part 'custom/question_answer_view.dart';

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

class AssignmentPageView extends StatefulWidget {
  final Assignment assignment;

  const AssignmentPageView({
    Key? key,
    required this.assignment,
  }) : super(key: key);

  @override
  State<AssignmentPageView> createState() => _AssignmentPageViewState();
}

class _AssignmentPageViewState extends State<AssignmentPageView> {
  late final Assignment assignment = widget.assignment;

  int currentIndex = 0;

  void setCurrentIndexToMostRecent() {
    final List<AssignmentOperation>? copy = assignment.answers?.copy;
    if (copy.isNullOrEmpty) return;

    copy!.sort(
      (a, b) {
        if (a.updatedAt.isBefore(b.updatedAt)) return -1;
        if (a.updatedAt.isAfter(b.updatedAt)) return 1;
        return 0;
      },
    );
    currentIndex = copy.lastIndex;
  }

  @override
  void initState() {
    super.initState();
    setCurrentIndexToMostRecent();
  }

  void onNextPressed() {
    if (currentIndex == assignment.questions.length - 1) return;
    setState(() {
      currentIndex++;
    });
  }

  void onPreviousPressed() {
    if (currentIndex == 0) return;
    setState(() {
      currentIndex--;
    });
  }

  void syncCallback() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QuestionIndicator(
          onNextPressed: onNextPressed,
          onPreviousPressed: onPreviousPressed,
          currentIndex: currentIndex,
          questionLength: assignment.questions.length,
        ),
        Consumer(
          builder: (context, ref, child) {
            return Padding(
              padding: EdgeInsets.only(top: 66.h),
              child: Builder(
                builder: (context) {
                  final AssignmentOperation question =
                      assignment.questions[currentIndex];
                  return _QuestionAnswerView(
                    assignment: assignment,
                    key: ValueKey('question answer view ${question.serialId}'),
                    question: question,
                    answer: assignment.answers?.firstWhereOrNull(
                      (element) => element.serialId == question.serialId,
                    ),
                    answerController: ref
                        .read(AssignmentStateNotifier.provider)
                        .answerControllers[currentIndex],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class QuestionIndicator extends StatelessWidget {
  final int currentIndex, questionLength;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  const QuestionIndicator({
    Key? key,
    required this.currentIndex,
    required this.questionLength,
    required this.onPreviousPressed,
    required this.onNextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentIndex == 0 ? null : onPreviousPressed,
          icon: Icon(
            Icons.arrow_back_ios,
            color: currentIndex == 0 ? AppColors.grey100 : AppColors.grey270,
          ),
        ),
        4.boxWidth,
        Text(
          'Question ${(currentIndex + 1).toString().padLeft(2, '0')} of'
          ' ${questionLength.toString().padLeft(2, '0')}',
          style: TextStyles.headline1.copyWith(
            fontSize: 20,
            color: AppColors.blue500,
          ),
        ),
        4.boxWidth,
        IconButton(
          onPressed:
              currentIndex == (questionLength - 1) ? null : onNextPressed,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: currentIndex == (questionLength - 1)
                ? AppColors.grey100
                : AppColors.grey270,
          ),
        ),
      ],
    );
  }
}
