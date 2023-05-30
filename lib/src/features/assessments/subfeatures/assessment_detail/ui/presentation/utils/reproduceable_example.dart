import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router_flow/go_router_flow.dart';

enum AppRoute {
  multipleChoiceAssessmentStage('m-c-assessment-stage'),
  theoryAssessmentQuestions('theory-assessment-questions'),
  theoryAssessmentStage(
    'theory-assessment-stage:operationIndex',
  ),
  assessmentPreview('assessment-preview'),
  assessmentReview('assessment-review'),
  ;

  final String path;

  const AppRoute(this.path);
}

enum NavigatorBarPage {
  theoryInstructions('Instructions', AppRoute.assessmentPreview),
  mcqInstructions('Instructions', AppRoute.assessmentPreview),
  multipleChoiceQuestions(
    'List of Questions',
    AppRoute.multipleChoiceAssessmentStage,
  ),
  listOfQuestions('List of Questions', AppRoute.theoryAssessmentQuestions),
  questions('Questions', AppRoute.theoryAssessmentStage),
  review('Review', AppRoute.assessmentReview),
  ;

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

  final String name;
  final AppRoute route;

  List<NavigatorBarPage> getPageFlowBy(Assessment assessment) {
    return switch (assessment.paperType) {
      PaperType.theory => theoryPages,
      PaperType.multipleChoice => mcqPages,
      _ => throw UnimplementedError(),
    };
  }

  void pushNextPage(BuildContext context, Assessment assessment) {
    final List<NavigatorBarPage> pageFlow = getPageFlowBy(assessment);
    final int index = pageFlow.indexOf(this);
    if (index == -1) return;

    if (index >= (pageFlow.length - 1)) return;

    if (pageFlow == mcqPages) {
      context.pushNamed(pageFlow[index + 1].route.name, extra: assessment);
      return;
    }
    context.pushNamed(
      theoryPages[index + 1].route.name,
      params: {
        if (theoryPages[index + 1].route == AppRoute.theoryAssessmentStage)
          'operationIndex': 0.toString(),
      },
      extra: assessment,
    );
  }

  void popToPrevious(BuildContext context, Assessment assessment) {
    final List<NavigatorBarPage> pageFlow = getPageFlowBy(assessment);
    final int index = pageFlow.indexOf(this);
    if (index == -1) return;

    if (index == 0) return;

    if (pageFlow == mcqPages) {
      context.pop();
      return;
    }
    context.pop();
  }

  const NavigatorBarPage(this.name, this.route);
}

class AssessmentNavigatorBar extends StatelessWidget {
  final Assessment assessment;
  final NavigatorBarPage page;

  const AssessmentNavigatorBar({
    Key? key,
    required this.assessment,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => page.popToPrevious(context, assessment),
          icon: SvgPicture.asset(
            VectorAssets.arrowLeft,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          page.name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => page.pushNextPage(context, assessment),
          icon: SvgPicture.asset(VectorAssets.arrowRight),
        ),
      ],
    );
  }
}

abstract final class Classy {
  static Widget buildNavigator() {
    print('buliding naviigator');
    return AssessmentNavigatorBar(
      assessment: Assessment(PaperType.multipleChoice),
      page: NavigatorBarPage.review,
    );
  }
}

// utils (should not be in this file)
abstract final class VectorAssets {
  static const String arrowRight = 'assets/vectors/arrow_right.svg';
  static const String arrowLeft = 'assets/vectors/arrow_left.svg';
}

class Assessment {
  final PaperType paperType;

  Assessment(this.paperType);
}

enum PaperType {
  theory,
  multipleChoice;
}
