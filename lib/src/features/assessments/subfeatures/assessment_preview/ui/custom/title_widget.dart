part of '../assessment_preview_page.dart';

class _TitleWidget extends ConsumerWidget {
  final Assessment assessment;

  const _TitleWidget({
    required this.assessment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String schoolName=ref.watch(School).state;
    return Column(
      children: [

      ],
    );
  }
}
