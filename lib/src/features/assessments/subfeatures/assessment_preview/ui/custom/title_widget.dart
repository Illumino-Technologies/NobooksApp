part of '../assessment_preview_page.dart';

class _TitleWidget extends ConsumerWidget {
  final Assessment assessment;

  const _TitleWidget({
    required this.assessment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String schoolName = ref.watch(SchoolNotifier.provider)!.name;
    return Column(
      children: [
        Text(
          schoolName.toUpperCase(),
          style: TextStyles.headline4.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        16.boxHeight,
        Text(
          '${assessment.term.ordinalText} ${assessment.type.longName}, '
          '${assessment.session.toLowerCase().removeAll('session').trim()}'
          ' Session',
          style: TextStyles.headline4.withHeight(1.25),
        ),
      ],
    );
  }
}
