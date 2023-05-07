part of '../record_page.dart';

class _RecordGraph extends ConsumerStatefulWidget {
  final List<Grade> grades;

  const _RecordGraph(
    this.grades, {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_RecordGraph> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<_RecordGraph> {
  List<Color> gradientColors = [AppColors.blueVariant, AppColors.white];
  String dropdownvalue = 'SS 2';
  String dropdownValue = '1st term';

  late final List<Grade> grades = widget.grades;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const TextStyle style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    print('value: $value');

    final Widget text = Text(
      grades[value.toInt()].subject.code.toUpperCase(),
      style: style,
      textAlign: TextAlign.center,
    );
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
    String text = '${value.toInt()}';

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  List<FlSpot> computeSpotListFromGrades() {
    return grades.map((e) {
      return FlSpot(
        grades.indexOf(e).toDouble(),
        (e.total ?? 0) < 20
            ? 20
            : (e.total ?? 0) - (Random().nextBool() ? 20 : 10),
      );
    }).toList();
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
                        minY: 0,
                        maxY: 100,
                        lineBarsData: [
                          LineChartBarData(
                            spots: computeSpotListFromGrades(),
                            isCurved: true,
                            color: Color(0xFF2548FF),
                            show: true,
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
                                colors: [
                                  Color(0xFF2548FF).withOpacity(0.24),
                                  Color(0xFF2548FF).withOpacity(0),
                                ],
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
