part of '../record_page.dart';

class _RecordGraph extends ConsumerStatefulWidget {
  const _RecordGraph({Key? key}) : super(key: key);

  @override
  ConsumerState<_RecordGraph> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<_RecordGraph> {
  List<Color> gradientColors = [AppColors.blueVariant, AppColors.white];
  String dropdownvalue = 'SS 2';
  String dropdownValue = '1st term';

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('MTH', style: style);
        break;
      case 2:
        text = const Text('ENG', style: style);
        break;
      case 3:
        text = const Text('CHE', style: style);
        break;
      case 4:
        text = const Text('PHY', style: style);
        break;
      case 5:
        text = const Text('BIO', style: style);
        break;
      case 6:
        text = const Text('ECN', style: style);
        break;
      case 7:
        text = const Text('FMT', style: style);
        break;
      case 8:
        text = const Text('CIV', style: style);

        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '0%';
        break;
      case 2:
        text = '10%';
        break;
      case 3:
        text = '20%';
        break;
      case 4:
        text = '30%';
        break;
      case 5:
        text = '40%';
        break;
      case 6:
        text = '50%';
        break;
      case 7:
        text = '60%';
        break;
      case 8:
        text = '70%';
        break;
      case 9:
        text = '80%';
        break;
      case 10:
        text = '90%';
        break;
      case 11:
        text = '100%';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Results',
                        style: TextStyles.headline6.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 90,
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: AppColors.blue50,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: dropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: [
                                  'SS 1',
                                  'SS 2',
                                  'SS 3',
                                ].map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: TextStyles.subHeading.copyWith(
                                        color: AppColors.neutral800,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          10.boxWidth,
                          Container(
                            height: 33.h,
                            width: 120.w,
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              color: AppColors.blue50,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                elevation: 0,
                                borderRadius: BorderRadius.circular(10),
                                icon: const Icon(
                                  Icons.expand_more,
                                  color: Colors.black,
                                ),
                                value: dropdownValue,
                                items: [
                                  '1st term',
                                  '2nd term',
                                  '3rd term',
                                ]
                                    .map(
                                      (week) => DropdownMenuItem<String>(
                                        value: week,
                                        child: Text(
                                          week,
                                          style: TextStyles.paragraph1.copyWith(
                                            color: AppColors.blue500,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    dropdownValue = val!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  20.boxHeight,
                  SizedBox(
                    height: 500,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: false,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 1.2,
                              getTitlesWidget: bottomTitleWidgets,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              // interval: 1,
                              getTitlesWidget: leftTitleWidgets,
                              reservedSize: 42,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                          border: Border.all(color: const Color(0xff37434d)),
                        ),
                        minX: 0,
                        maxX: 11,
                        minY: 0,
                        maxY: 6,
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 3),
                              FlSpot(2.6, 2),
                              FlSpot(4.9, 5),
                              FlSpot(6.8, 3.1),
                              FlSpot(8, 4),
                              FlSpot(9.5, 3),
                              FlSpot(11, 4),
                            ],
                            isCurved: true,
                            gradient: LinearGradient(
                              colors: gradientColors,
                            ),
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              show: false,
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: gradientColors
                                    .map((color) => color.withOpacity(0.3))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
