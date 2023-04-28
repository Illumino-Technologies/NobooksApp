import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/assignments/domain/fakes/fake_assignments.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        color: AppColors.subjectLightBlueVariant.withOpacity(1),
        onPressed: () {
          context.goNamed(
            AppRoute.assignment.name,
            extra: FakeAssignments.biologyAssignment,
          );
        },
      ),
    );
  }
}
