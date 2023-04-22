import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/domain/fakes/subject/fake_subjects.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

part 'custom/record_graph.dart';

part 'custom/record_view.dart';

part 'custom/subjects_side_tab.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            child: _RecordView(),
          ),
          _SubjectsSideTab(),
        ],
      ),
    );
  }
}
