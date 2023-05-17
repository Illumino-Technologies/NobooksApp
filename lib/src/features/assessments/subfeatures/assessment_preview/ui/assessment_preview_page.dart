import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';

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

class _Instructions extends StatelessWidget {
  final Assessment assessment;

  const _Instructions({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _InfoRow extends StatelessWidget {
  final Assessment assessment;

  const _InfoRow({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _TitleWidget extends ConsumerWidget {
  final Assessment assessment;

  const _TitleWidget({
    required this.assessment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
