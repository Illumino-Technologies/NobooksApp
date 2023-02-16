import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/dashboard/dashboard_barrel.dart';
import 'package:nobook/src/features/dashboard/view/widgets/dashboar_widget.dart';
import 'package:nobook/src/features/dashboard/view/widgets/reusable_cardWidget.dart';
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
        width: context.screenWidth * 0.50,
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
                  Text(
                    'Veiw all >',
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: context.screenHeight * 0.25,
                child: ListView.builder(
                  itemCount: FakeDashboardData.dashBoard.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ReuseableCard(
                      firstImage:
                          FakeDashboardData.dashBoard[index].firstImage,
                      secondImage:
                          FakeDashboardData.dashBoard[index].secondImage,
                      title: FakeDashboardData.dashBoard[index].title,
                      subTitle: FakeDashboardData.dashBoard[index].subTitle,
                      bottomsubTitle:
                          FakeDashboardData.dashBoard[index].bottomsubTitle,
                      bottomtitle:
                          FakeDashboardData.dashBoard[index].bottomtitle,
                    );
                  },
                ),
              ),
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
                    'Veiw all >',
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: context.screenHeight * 0.25,
                child: ListView.builder(
                  itemCount: FakeDashboardData.dashBoard.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ReuseableCard(
                      firstImage:
                          FakeDashboardData.dashBoard[index].firstImage,
                      secondImage:
                          FakeDashboardData.dashBoard[index].secondImage,
                      title: FakeDashboardData.dashBoard[index].title,
                      subTitle: FakeDashboardData.dashBoard[index].subTitle,
                      bottomsubTitle:
                          FakeDashboardData.dashBoard[index].bottomsubTitle,
                      bottomtitle:
                          FakeDashboardData.dashBoard[index].bottomtitle,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
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
