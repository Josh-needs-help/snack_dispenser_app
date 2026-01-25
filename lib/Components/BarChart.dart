import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoryBarChart extends StatelessWidget {
  final List<int> data;
  const HistoryBarChart({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    List<String> titles = ["Morning", "Afternoon", "Evening", "Night"];
    final maxY = data.isEmpty
        ? 0.0
        : data.reduce((a, b) => a > b ? a : b).toDouble();
    return Transform.rotate(
      angle: 3.1415926 / 2,
      child: BarChart(
        BarChartData(
          maxY: maxY.toDouble(),
          minY: 0,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 15,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index < 0 || index >= titles.length) return Container();
                  return Transform.rotate(
                    angle:-3.1415926 / 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,70,0),
                      child: Text(
                        titles[index],
                        style: const TextStyle(
                          color: Color.fromARGB(255, 167, 167, 167),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
                interval: 1,
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            data.length,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data[index].toDouble(),
                  color: Colors.blue,
                  width: 20,

                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.3),
                      Colors.blue.withOpacity(0.7),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
