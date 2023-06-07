import 'package:fl_chart/fl_chart.dart';
import '../../models/progress_point.dart';
import 'package:flutter/material.dart';
import '../../shared/globals.dart';

class LineChartWidget extends StatefulWidget {
  final List<ProgressPoint> points;

  const LineChartWidget({Key? key, required this.points}) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<Color> gradientColors = [
    AppColors.redAccent,
    AppColors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(LineChartData(
        backgroundColor: AppColors.black54,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppColors.white10,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: AppColors.white10,
              strokeWidth: 1,
            );
          },
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
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: LeftTitelWidget,
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: AppColors.black),
        ),
        minY: 0,
        maxY: 103,
        maxX: widget.points.length + 1 / 4 * widget.points.length,
        lineBarsData: [
          LineChartBarData(
            spots: widget.points
                .map((point) => FlSpot(point.week.toDouble(), point.percent))
                .toList(),
            isCurved: true,
            gradient: LinearGradient(
              colors: gradientColors,
            ),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget LeftTitelWidget(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 10, color: AppColors.black);
    String text;
    if (value.toInt() % 10 == 0) {
      text = value.toInt().toString();
    } else {
      return Container();
    }
    return Text(
      text,
      style: style,
      textAlign: TextAlign.left,
    );
  }
}
