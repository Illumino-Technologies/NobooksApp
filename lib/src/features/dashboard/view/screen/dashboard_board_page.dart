import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/dashboard/view/widgets/dashboar_widget.dart';
import 'package:nobook/src/features/dashboard/view/widgets/reusable_cardWidget.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/notes/model/note_list.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class DashboardBoardPage extends ConsumerStatefulWidget {
  const DashboardBoardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardBoardPage> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardBoardPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 761.w,
        decoration: const BoxDecoration(
          color: AppColors.backgroundGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //YMargin(10),
              const DashboardWidget(),
              20.boxHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Notes',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.goNamed(AppRoute.note.name);
                    },
                    child: const Text(
                      'View all >',
                      style: TextStyle(
                        color: AppColors.blue500,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              24.boxHeight,
              SizedBox(
                height: 160.h,
                child: ListView.separated(
                  itemCount: FakeNotes.allNotes.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => 16.boxWidth,
                  itemBuilder: (context, index) {
                    return SubjectNoteWidget(
                      currentNote: FakeNotes.allNotes[index],
                    );
                  },
                ),
              ),
              32.boxHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Assignments',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'View all >',
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              24.boxHeight,
              SizedBox(
                height: context.screenHeight * 0.25,
                child: ListView.separated(
                  itemCount: FakeAssignmentData.assignments.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => 16.boxWidth,
                  itemBuilder: (context, index) {
                    return AssignmentNoteWidget(
                      currentAssignment: FakeAssignmentData.assignments[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 694,
                    height: 433,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage("assets/graph.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
