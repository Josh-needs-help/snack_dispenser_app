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
    List<int> days = [1,5,10,15,20,25,30];
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
                final x = value.toInt();

                if (mode == "weekly") {
                  if (x < 0 || x >= weekDays.length)
                  {
                     return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      weekDays[x],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 167, 167, 167),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  );
                }

                if (mode == "yearly") {
                  if (x < 0 || x >= months.length)
                  {
                     return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      months[x],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 167, 167, 167),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  );
                }

                if (days.contains(x)) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      x.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 167, 167, 167),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
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
                      fontSize: 10,
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
