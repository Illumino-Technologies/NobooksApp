part of '../assessment_preview_page.dart';

class _InfoRow extends ConsumerWidget {
  final Assessment assessment;

  const _InfoRow({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Student student = ref.watch(StudentNotifier.provider)!;
    return Wrap(
      spacing: 76.w,
      children: [
        _Item(
          title: 'Subject',
          value: assessment.subject.name,
        ),
        _Item(
          title: 'Class',
          value: student.studentClass.name,
        ),
        _Item(
          title: 'Paper Type',
          value: assessment.paperType.text,
        ),
        _Item(
          title: 'Duration',
          value: durationToHours(assessment.duration),
        ),
      ],
    );
  }
  
  String durationToHours(int duration){
    final int hours = duration ~/ 60;
    final int minutes = duration % 60;
    if(minutes == 0) return '$hours hr${hours.pluralValue}';
    if(hours == 0) return '$minutes min${minutes.pluralValue}';
    return '$hours hr${hours.pluralValue} $minutes min${minutes.pluralValue}';
  }
  
}

class _Item extends StatelessWidget {
  final String title;
  final String value;

  const _Item({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title: ',
        style: TextStyles.headline6.copyWith(
          fontWeight: FontWeight.w700,
          height: 1.333,
          color: AppColors.neutral600,
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyles.headline6.copyWith(
              fontWeight: FontWeight.w400,
              height: 1.333,
            ),
          )
        ],
      ),
    );
  }
}
