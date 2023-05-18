import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';

part 'custom/assessment_stage_view.dart';

class AssessmentStagePage extends ConsumerStatefulWidget {
  final Assessment assessment;

  const AssessmentStagePage({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AssessmentStagePageState();
}

class _AssessmentStagePageState extends ConsumerState<AssessmentStagePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(AssessmentStageNotifier.provider.notifier).initializeData(
            widget.assessment,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [


            Container(),
          ],
        ),
      ),
    );
  }
}
