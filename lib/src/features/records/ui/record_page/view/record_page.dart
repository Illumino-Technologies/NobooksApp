import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/domain/fakes/subject/fake_subjects.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

part 'custom/grades_table.dart';

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
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void jump() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent.percent(80),
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _RecordView(),
                  _GradesTable(),
                  _GradesTable(),
                  _GradesTable(),
                  _GradesTable(),
                  _GradesTable(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: jump,
            child: Text('jump'),
          ),
          _SubjectsSideTab(),
          CustomScrollbar(
            controller: _scrollController,
          ),
        ],
      ),
    );
  }
}

class CustomScrollbar extends StatefulWidget {
  final ScrollController controller;

  const CustomScrollbar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomScrollbar> createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<CustomScrollbar> {
  ScrollController get controller => widget.controller;

  Future<void> resetActive() async {
    active = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    active = false;
  }

  bool _active = false;

  bool get active => _active;

  set active(bool value) {
    if (value ^ _active) {
      setState(() {
        _active = value;
      });
    }
  }

  void onTap(TapUpDetails details) {}

  void onVerticalDragUpdate(DragUpdateDetails details) {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _Track(
          active: active,
          onTap: onTap,
        ),
        ListenableBuilder(
          listenable: controller,
          builder: (context) {
            return Positioned(
              top: controller.offset,
              child: _Thumb(
                onVerticalDrag: onVerticalDragUpdate,
                active: active,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _Track extends StatelessWidget {
  final double? width;
  final double? height;
  final bool active;
  final GestureTapUpCallback onTap;

  const _Track({
    Key? key,
    this.width,
    this.height,
    required this.active,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: onTap,
      child: Container(
        height: height?.h ?? double.infinity,
        width: width?.w ?? 16.w,
        decoration: BoxDecoration(
          color: AppColors.grey100.withOpacity(active ? 1 : 0.5),
          borderRadius: Ui.allBorderRadius(100.r),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  final double? width;
  final double? height;
  final GestureDragUpdateCallback onVerticalDrag;
  final bool active;

  const _Thumb({
    Key? key,
    this.width,
    this.height,
    required this.onVerticalDrag,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: onVerticalDrag,
      child: Container(
        height: height?.h ?? 161.h,
        width: width?.w ?? 16.w,
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(active ? 1 : 0.5),
          borderRadius: Ui.allBorderRadius(100.r),
        ),
      ),
    );
  }
}
