import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

part 'custom/grades_table.dart';

part 'custom/grading_column.dart';

part 'custom/record_graph.dart';

part 'custom/record_view.dart';

part 'custom/subjects_side_tab.dart';

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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  reverse: true,
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
    );
  }
}
