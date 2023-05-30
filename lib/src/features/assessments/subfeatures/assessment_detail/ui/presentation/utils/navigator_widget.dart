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
    'Questions',
    AppRoute.multipleChoiceAssessmentStage,
  ),
  listOfQuestions('List of Questions', AppRoute.theoryAssessmentQuestions),
  questions('Questions', AppRoute.theoryAssessmentStage),
  review('Review', AppRoute.assessmentReview),
  ;

  final String name;
  final AppRoute route;

  List<NavigatorBarPage> getPageFlowBy(Assessment assessment) {
    return switch (assessment.paperType) {
      PaperType.theory => AssessmentNavigatorBar.theoryPages,
      PaperType.multipleChoice => AssessmentNavigatorBar.mcqPages,
      _ => throw UnimplementedError(),
    };
  }

  bool isLastIndex(Assessment assessment) {
    final List<NavigatorBarPage> pageFlow = getPageFlowBy(assessment);
    return pageFlow.indexOf(this) == pageFlow.lastIndex;
  }

  bool isFirstIndex(Assessment assessment) {
    final List<NavigatorBarPage> pageFlow = getPageFlowBy(assessment);
    return pageFlow.indexOf(this) == 0;
  }

  void pushNextPage(BuildContext context, Assessment assessment) {
    final List<NavigatorBarPage> pageFlow = getPageFlowBy(assessment);
    final int index = pageFlow.indexOf(this);
    if (index == -1) throw Failure(message: ErrorMessages.somethingWentWrong);

    if (index >= pageFlow.lastIndex) return;

    if (pageFlow == AssessmentNavigatorBar.mcqPages) {
      context.pushNamed(pageFlow[index + 1].route.name, extra: assessment);
      return;
    }
    context.pushNamed(
      AssessmentNavigatorBar.theoryPages[index + 1].route.name,
      params: {
        if (AssessmentNavigatorBar.theoryPages[index + 1].route ==
            AppRoute.theoryAssessmentStage)
          'operationIndex': 0.toString(),
      },
      extra: assessment,
    );
  }

  void popToPrevious(BuildContext context, Assessment assessment) {
    final List<NavigatorBarPage> pageFlow = getPageFlowBy(assessment);
    final int index = pageFlow.indexOf(this);
    if (index == -1) throw Failure(message: ErrorMessages.somethingWentWrong);

    if (index == 0) return;

    if (pageFlow == AssessmentNavigatorBar.mcqPages) {
      context.pop();
      return;
    }
    context.pop();
  }

  const NavigatorBarPage(this.name, this.route);
}

class AssessmentNavigatorBar extends ConsumerWidget {
  final Assessment assessment;
  final NavigatorBarPage page;

  const AssessmentNavigatorBar({
    Key? key,
    required this.assessment,
    required this.page,
  }) : super(key: key);

  static List<NavigatorBarPage> theoryPages = [
    NavigatorBarPage.theoryInstructions,
    NavigatorBarPage.listOfQuestions,
    NavigatorBarPage.questions,
    NavigatorBarPage.review,
  ];

  static List<NavigatorBarPage> mcqPages = [
    NavigatorBarPage.mcqInstructions,
    NavigatorBarPage.multipleChoiceQuestions,
    NavigatorBarPage.review,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          onPressed: page.isFirstIndex(assessment)
              ? null
              : () {
                  if (page.isLastIndex(assessment)) {
                    if (ref
                            .read(AssessmentTimerStateNotifier.requireProvider)
                            .inSeconds <=
                        1) return;
                  }
                  page.popToPrevious(context, assessment);
                },
          icon: SvgPicture.asset(
            VectorAssets.arrowLeft,
            color: page.isFirstIndex(assessment) ? AppColors.neutral400 : null,
          ),
        ),
        8.boxWidth,
        Text(
          page.name,
          style: TextStyles.subHeading.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.blue500,
          ),
        ),
        8.boxWidth,
        IconButton(
          onPressed: page.isLastIndex(assessment)
              ? null
              : () => page.pushNextPage(context, assessment),
          icon: SvgPicture.asset(
            VectorAssets.arrowRight,
            color: page.isLastIndex(assessment) ? AppColors.neutral200 : null,
          ),
        ),
      ],
    );
  }
}
