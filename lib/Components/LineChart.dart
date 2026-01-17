import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoryLineChart extends StatelessWidget {
  final List<int> data;
  final String mode;
  const HistoryLineChart({super.key, required this.data, required this.mode});
  @override
  Widget build(BuildContext context) {
    List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final maxY = data.isEmpty
        ? 0.0
        : data.reduce((a, b) => a > b ? a : b).toDouble();
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: intToSpots(),
            isCurved: true,
            barWidth: 2,
            color: Colors.blue,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
            dotData: FlDotData(show: false),
          ),
        ],
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                List<String> titles = mode == "weekly" ? weekDays : months;
                if (index < 0 || index >= titles.length) return Container();
                return Text(
                  titles[index],
                  style: TextStyle(
                    color: const Color.fromARGB(255, 167, 167, 167),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: maxY == 0 ? 1 : maxY,
              getTitlesWidget: (value, meta) {
                if (value == maxY) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: const Color.fromARGB(255, 167, 167, 167),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> intToSpots() {
    return List.generate(
      data.length,
      (i) => FlSpot(i.toDouble(), data[i].toDouble()),
    );
  }
}
