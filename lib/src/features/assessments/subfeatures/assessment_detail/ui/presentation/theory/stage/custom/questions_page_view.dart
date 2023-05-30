part of '../theory_stage_page.dart';

class _QuestionPageView extends ConsumerStatefulWidget {
  final Assessment assessment;
  final OperationIndices initialIndices;

  const _QuestionPageView({
    Key? key,
    required this.assessment,
    required this.initialIndices,
  }) : super(key: key);

  @override
  ConsumerState createState() => __QuestionPageViewState();
}

class __QuestionPageViewState extends ConsumerState<_QuestionPageView> {
  late List<TheoryAssessmentOperation> operations =
      widget.assessment.assessments.cast();
  final Map<OperationIndices, AssessmentOperation> operationMap = {};

  void splitList() {
    final Map<OperationIndices, AssessmentOperation> map = {};

    for (int i = 0; i < operations.length; i++) {
      final TheoryAssessmentOperation operation = operations[i];

      if (operation.subOperations.isEmpty) {
        map[(operationIndex: i, subIndex: null)] = operation;
        continue;
      }

      for (int j = 0; j < operation.subOperations.length; j++) {
        map[(operationIndex: i, subIndex: j)] = operation.subOperations[j];
      }
    }

    operationMap.clear();
    operationMap.addAll(Map.from(map));
  }

  @override
  void initState() {
    super.initState();
    splitList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigateToInitialIndex();
    });
  }

  void navigateToInitialIndex() {
    final int initialIndex = operationMap.keys.toList().indexOf(
          widget.initialIndices,
        );
    if (initialIndex == -1) return;

    controller.jumpToPage(initialIndex);
  }

  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    currentPageNotifier.dispose();
    super.dispose();
  }

  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

  void changePage(int page) {
    refreshPages(page);
    controller.jumpToPage(page);
    currentPageNotifier.value = page;
  }

  void refreshPages(int pageIndex) {
    operations = List.from(
      ref
          .read(AssessmentStageNotifier.provider)
          .assessment!
          .assessments
          .cast<TheoryAssessmentOperation>(),
    );
    splitList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.boxHeight,
        Row(
          children: [
            const AssessmentTimerWidget(),
            const Spacer(),
            AssessmentNavigatorBar(
              assessment: widget.assessment,
              page: NavigatorBarPage.questions,
            ),
            const Spacer(),
            ValueListenableBuilder<int>(
              valueListenable: currentPageNotifier,
              builder: (_, value, __) {
                return Text(
                  'Question ${'${value + 1}'.padLeft(
                    2,
                    '0',
                  )} of ${'${operationMap.length}'.padLeft(2, '0')}',
                  style: TextStyles.subHeading.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue500,
                  ),
                );
              },
            ),
          ],
        ),
        24.boxHeight,
        Expanded(
          child: PageView.builder(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: operationMap.length,
            itemBuilder: (context, index) {
              final OperationIndices operationKey = operationMap.keys.elementAt(
                index,
              );

              return MultiPointerSingleChildScrollView(
                pointerCount: 2,
                child: operationMap[operationKey] is TheoryAssessmentOperation
                    ? _TheoryAssessmentOperationItem(
                        operation: operationMap[operationKey]
                            as TheoryAssessmentOperation,
                        indices: operationKey,
                        key: ValueKey('not leaf $operationKey'),
                      )
                    : _TheoryAssessmentOperationLeafItem(
                        operation: operationMap[operationKey]
                            as TheoryAssessmentOperationLeaf,
                        indices: operationKey,
                        key: ValueKey('leaf $operationKey'),
                      ),
              );
            },
          ),
        ),
        AssessmentSelector(
          onChanged: changePage,
          currentItem: operationMap.keys.toList().indexOfOrNull(
                    widget.initialIndices,
                  ) ??
              controller.page?.toInt() ??
              0,
          length: operationMap.length,
        ),
      ],
    );
  }

  int getControllerPage() {
    try {
      return controller.page!.toInt();
    } catch (e) {
      return 0;
    }
  }
}
