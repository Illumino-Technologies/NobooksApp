part of '../record_page.dart';

class _RecordView extends ConsumerWidget {
  const _RecordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Grade> allGrades = ref.watch(
      RecordsNotifier.provider.select((value) => value.allGrades),
    );
    return Column(
      children: [
        _RecordGraph(allGrades),
      ],
    );
  }
}
