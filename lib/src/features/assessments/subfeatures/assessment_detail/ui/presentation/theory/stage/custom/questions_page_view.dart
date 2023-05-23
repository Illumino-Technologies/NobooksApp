part of '../theory_stage_page.dart';

class _QuestionPageView extends StatefulWidget {
  final Assessment assessment;
  final OperationIndices initialIndices;

  const _QuestionPageView({
    Key? key,
    required this.assessment,
    required this.initialIndices,
  }) : super(key: key);

  @override
  State<_QuestionPageView> createState() => _QuestionPageViewState();
}

class _QuestionPageViewState extends State<_QuestionPageView> {
  late final List<TheoryAssessmentOperation> operations =
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
    super.dispose();
  }

  void changePage(int page) {
    controller.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        ListenableBuilder(
          listenable: controller,
          builder: (context) {
            return AssessmentSelector(
              onChanged: changePage,
              currentItem: operationMap.keys.toList().indexOfOrNull(
                        widget.initialIndices,
                      ) ??
                  controller.page?.toInt() ??
                  0,
              length: operationMap.length,
            );
          },
        ),
      ],
    );
  }
}
