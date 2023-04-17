import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/domain/fakes/subject/fake_subjects.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

class RecordPage extends ConsumerStatefulWidget {
  const RecordPage({super.key, this.styles});
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
          Expanded(
            child: Text('Record Page'),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Column(
                children: [
                  Text('All Subjects Taken Up',
                      style: TextStyles.headline1.withSize(24)),
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Continous Assessment',
                                  style: TextStyles.headline1.withSize(20)),
                              SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Padding(
                                    padding: EdgeInsets.all(5.w),
                                    child: const Text('40')),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Examination',
                                  style: TextStyles.headline1.withSize(20)),
                              SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Padding(
                                    padding: EdgeInsets.all(5.w),
                                    child: const Text('40'),),
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
