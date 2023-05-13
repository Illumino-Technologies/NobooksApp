part of '../record_page.dart';

class _RecordGraph extends ConsumerStatefulWidget {
  final List<Grade> grades;
  const _RecordGraph({required this.grades, Key? key}) : super(key: key);

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
    final int index = value.toInt();

    final Widget text = Text(
      grades[index].subject.code.toUpperCase(),
      style: style,
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
    String text = '${(value.toInt() + 1) * 10}%';
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
                            spots: spots,
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

  final List<FlSpot> spots = [];
  late final List<Grade> grades = widget.grades;

  void manipulateData() {
    spots.clear();
    spots.addAll(convertGradesToPoints(grades));
  }

  List<FlSpot> convertGradesToPoints(List<Grade> grades) {
    return grades.map<FlSpot>((e) {
      return FlSpot(grades.indexOf(e).toDouble(), e.total ?? 0);
    }).toList();
  }
}
