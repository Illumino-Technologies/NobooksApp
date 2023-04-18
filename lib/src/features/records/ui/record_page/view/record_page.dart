import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/domain/fakes/subject/fake_subjects.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

part 'custom/record_graph.dart';

part 'custom/record_view.dart';

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
        children: [
          const Expanded(
            child: _RecordView(),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Subjects Taken Up',
                    style: TextStyles.headline3.withSize(18),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.85,
                    width: 320.w,
                    child: ListView.builder(
                      itemCount: FakeSubjects.subjects.length,
                      itemBuilder: (context, index) => ExpansionTile(
                        leading: SubjectWidget(
                          subject: FakeSubjects.subjects[index],
                          boxSize: 40.r,
                          fontSize: 25.sp,
                        ),
                        title: Text(
                          FakeSubjects.subjects[index].name,
                          style: TextStyles.paragraph1.asSemibold,
                        ),
                        childrenPadding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 20.h,
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Continuous Assessment',
                                style: TextStyles.paragraph1.withSize(10),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: const Text('40'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Examination',
                                style: TextStyles.paragraph1.withSize(10),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: const Text('40'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
