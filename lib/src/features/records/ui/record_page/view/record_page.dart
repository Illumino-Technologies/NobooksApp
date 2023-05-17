import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

part 'custom/class_drop_down.dart';

part 'custom/grades_table.dart';

part 'custom/grading_column.dart';

part 'custom/line_chart_widget.dart';

part 'custom/record_graph.dart';

part 'custom/record_view.dart';

part 'custom/subjects_side_tab.dart';

part 'custom/term_drop_down.dart';

part 'utils/enum/grading_table_column.dart';

class RecordPage extends ConsumerStatefulWidget {
  const RecordPage({
    super.key,
    this.styles,
  });

  final TextStyles? styles;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecordPageState();
}

class _RecordPageState extends ConsumerState<RecordPage> {
  final ScrollController _scrollController = ScrollController();

  Future<void> initializeProvider() async {
    if (ref.read(RecordsNotifier.provider).allGrades.isNotEmpty) {
      return WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(RecordsNotifier.provider.notifier).refresh(shouldLoad: false);
      });
    }
    ref.read(RecordsNotifier.provider.notifier).dispose();
    await ref
        .read(
          RecordsNotifier.newProvider(
            source: FakeRecordsSource(),
            classRepo: ClassRepository.new_(source: FakeClassSource()),
          ).notifier,
        )
        .initializeNotifier();
  }

  @override
  void initState() {
    super.initState();
    initializeProvider();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = ref.watch(
      RecordsNotifier.provider.select(
        (value) => value.loading,
      ),
    );
    final bool shouldShowWidgets = ref.watch(
      RecordsNotifier.provider.select(
        (value) => value.classGrades.isNotEmpty,
      ),
    );
    if (!shouldShowWidgets && loading) {
      return const LoaderWidget();
    }

    return Stack(
      children: [
        Scaffold(
          body: ScrollbarTheme(
            data: ScrollbarThemeData(
              trackBorderColor: MaterialStateProperty.all(Colors.transparent),
              trackColor: MaterialStateProperty.all(AppColors.grey100),
              thumbColor: MaterialStateProperty.all(AppColors.grey),
            ),
            child: Scrollbar(
              controller: _scrollController,
              thickness: 16.w,
              radius: const Radius.circular(100),
              interactive: true,
              thumbVisibility: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          const _RecordView(),
                          48.boxHeight,
                          const _GradesTable(),
                          48.boxHeight,
                        ],
                      ),
                    ),
                  ),
                  const _SubjectsSideTab(),
                ],
              ),
            ),
          ),
        ),
        if (loading)
          LoaderWidget(
            backgroundColor: AppColors.black.withOpacity(0.2),
          ),
      ],
    );
  }
}
