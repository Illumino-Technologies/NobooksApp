import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/assessments/assessments_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

enum NavigatorBarPage {
  theoryInstructions('Instructions', AppRoute.assessmentPreview),
  mcqInstructions('Instructions', AppRoute.assessmentPreview),
  multipleChoiceQuestions(
    'List of Questions',
    AppRoute.multipleChoiceAssessmentStage,
  ),
  listOfQuestions('List of Questions', AppRoute.theoryAssessmentQuestions),
  questions('Question 01 of 16', AppRoute.theoryAssessmentStage),
  ;

  static List<NavigatorBarPage> theoryPages = [
    theoryInstructions,
    listOfQuestions,
    questions,
  ];

  static List<NavigatorBarPage> mcqPages = [
    mcqInstructions,
    multipleChoiceQuestions,
  ];

  final String name;
  final AppRoute route;

  void navigateToNext(BuildContext context, Assessment assessment) {
    if (theoryPages.contains(this)) {
      final int index = theoryPages.indexOf(this);
      if (index < theoryPages.lastIndex) {
        context.goNamed(
          theoryPages[index + 1].route.name,
          params: {
            if (theoryPages[index + 1].route == AppRoute.theoryAssessmentStage)
              'operationIndex': 0.toString(),
          },
          extra: assessment,
        );
      }
      return;
    }
    if (mcqPages.contains(this)) {
      final int index = mcqPages.indexOf(this);
      if (index < mcqPages.lastIndex) {
        context.goNamed(
          mcqPages[index + 1].route.name,
          extra: assessment,
        );
      }
    }
  }

  void navigateToPrevious(
    BuildContext context, {
    required Assessment assessment,
    required bool canPopToInstructions,
  }) {
    if (theoryPages.contains(this)) {
      if (this == NavigatorBarPage.listOfQuestions && !canPopToInstructions)
        return;
      if (index > 0) return context.pop();
    }
    if (mcqPages.contains(this)) {
      if (this == NavigatorBarPage.mcqInstructions && !canPopToInstructions) {
        return;
      }
      final int index = mcqPages.indexOf(this);
      if (index > 0) {
        context.pop();
      }
    }
  }

  const NavigatorBarPage(this.name, this.route);
}

class AssessmentNavigatorBar extends ConsumerWidget {
  final VoidCallback onBackPressed;
  final bool backDisabled;
  final bool forwardDisabled;
  final VoidCallback onForwardPressed;
  final String titleText;

  const AssessmentNavigatorBar({
    Key? key,
    this.backDisabled = false,
    this.forwardDisabled = false,
    required this.onBackPressed,
    required this.onForwardPressed,
    required this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          onPressed: backDisabled ? null : onBackPressed,
          icon: SvgPicture.asset(
            VectorAssets.arrowLeft,
          ),
        ),
        200.boxWidth,
        IconButton(
          onPressed: forwardDisabled ? null : onForwardPressed,
          icon: SvgPicture.asset(VectorAssets.arrowRight),
        ),
        const Spacer(),
      ],
    );
  }
}
