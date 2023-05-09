part of '../record_page.dart';

class _RecordView extends ConsumerWidget {
  const _RecordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<Class, List<Grade>> classGrades = ref.watch(
      RecordsNotifier.provider.select((value) => value.classGrades),
    );
    return _RecordGraph(classGrades: classGrades);
  }
}
