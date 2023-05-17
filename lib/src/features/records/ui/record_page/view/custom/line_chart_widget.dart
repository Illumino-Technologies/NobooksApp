part of '../record_page.dart';

class LineChartWidget extends StatelessWidget {
  final List<Grade> grades;

  const LineChartWidget({
    Key? key,
    required this.grades,
  }) : super(key: key);

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text = '${value.toInt()}';

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const TextStyle style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

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

  List<FlSpot> computeSpotListFromGrades() {
    return grades.map((e) {
      return FlSpot(
        grades.indexOf(e).toDouble(),
        e.total ?? 0,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
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
            color: const Color(0xFF2548FF),
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
                  const Color(0xFF2548FF).withOpacity(0.24),
                  const Color(0xFF2548FF).withOpacity(0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
