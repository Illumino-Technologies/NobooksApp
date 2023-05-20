import 'package:flutter/material.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';

class TheoryStageView extends StatefulWidget {
  final Assessment assessment;

  const TheoryStageView({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  State<TheoryStageView> createState() => _TheoryStageViewState();
}

class _TheoryStageViewState extends State<TheoryStageView> {
  final ValueNotifier<int?> answerStageIndexNotifier = ValueNotifier<int?>(
    null,
  );

  @override
  void dispose() {
    super.dispose();
    answerStageIndexNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
