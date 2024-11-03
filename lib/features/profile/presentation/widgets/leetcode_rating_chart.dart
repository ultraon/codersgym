import 'dart:math';

import 'package:dailycoder/features/profile/presentation/widgets/leetcode_user_profile_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:collection/collection.dart';

class LeetcodeRatingChart extends HookWidget {
  final List<DataPoint> dataPoints;

  const LeetcodeRatingChart({super.key, required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final averageY = dataPoints.map((e) => e.y).average;
    final averageDataPoint = dataPoints.map(
      (e) => e.toFlSpot().copyWith(
            y: averageY,
          ),
    );
    final animationShown = useState(false);
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 800), () {
        animationShown.value = true;
      });
      return;
    }, []);

    return AspectRatio(
      aspectRatio: 1.80,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInSine,
          LineChartData(
            gridData: const FlGridData(
              show: false,
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  maxIncluded: true,
                  getTitlesWidget: leftTitleWidgets,
                  reservedSize: 42,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            minY: dataPoints
                .reduce(
                    (value, element) => value.y < element.y ? value : element)
                .y,
            maxY: dataPoints
                .reduce(
                    (value, element) => value.y > element.y ? value : element)
                .y,
            lineBarsData: [
              LineChartBarData(
                spots: animationShown.value
                    ? dataPoints
                        .map(
                          (e) => e.toFlSpot(),
                        )
                        .toList()
                    : averageDataPoint.toList(),
                isCurved: true,
                color: Theme.of(context).primaryColor,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(
                  show: false,
                ),
                curveSmoothness: 0.5,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [theme.primaryColor, Colors.transparent]
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) {
                  return theme.primaryColorDark;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  double calculateInterval(List<DataPoint> values) {
    // Check if the list is not empty
    if (values.isEmpty) return 0;

    // Find the max and min values in the list
    final maxValue = values.reduce((a, b) => a.y > b.y ? a : b);
    final minValue = values.reduce((a, b) => a.y < b.y ? a : b);

    // Calculate the range
    double range = maxValue.y - minValue.y;

    // Calculate the interval to show 10 points at max
    double interval = range / 4;

    // Ensure interval is positive
    return interval > 0
        ? interval
        : 1; // If range is very small, set a minimum interval of 1
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return Text(
      value.toInt().toString(),
      style: style,
    );
  }
}

class DataPoint {
  final double x;
  final double y;

  const DataPoint(this.x, this.y);
}

extension DataPointExt on DataPoint {
  FlSpot toFlSpot() => FlSpot(x, y);
}
