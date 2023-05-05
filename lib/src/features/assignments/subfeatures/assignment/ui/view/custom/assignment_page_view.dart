part of '../assignment_screen.dart';

class AssignmentPageView extends ConsumerStatefulWidget {
  final Assignment assignment;

  const AssignmentPageView({
    Key? key,
    required this.assignment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AssignmentPageViewState();
}

class _AssignmentPageViewState extends ConsumerState<AssignmentPageView> {
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

  void syncCallback() {
    ref.read(AssignmentStateNotifier.provider.notifier).syncAssignmentAnswer(
          currentIndex,
        );
  }

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
