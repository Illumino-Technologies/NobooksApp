import 'package:flutter/material.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';

class AssessmentDetailPage extends StatelessWidget {
  final Assessment assessment;
  final AssessmentType type;

  const AssessmentDetailPage({
    Key? key,
    required this.assessment,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
