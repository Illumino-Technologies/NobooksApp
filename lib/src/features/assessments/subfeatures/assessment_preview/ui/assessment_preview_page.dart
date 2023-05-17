import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';

part 'custom/assessment_conduct.dart';

part 'custom/assessment_instructions.dart';

part 'custom/info_row.dart';

part 'custom/student_declaration.dart';

part 'custom/title_widget.dart';

class AssessmentPreviewPage extends StatelessWidget {
  final Assessment assessment;

  const AssessmentPreviewPage({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TitleWidget(assessment: assessment),
        _InfoRow(assessment: assessment),
      ],
    );
  }
}
