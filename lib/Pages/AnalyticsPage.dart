import 'package:flutter/material.dart';
import 'package:snack_dispenser_app/Components/AutoScaleText.dart';
import 'package:snack_dispenser_app/Components/LineChart.dart';
import 'package:snack_dispenser_app/Components/StaticContainer.dart';
import 'package:snack_dispenser_app/Models/History.dart';
import 'package:snack_dispenser_app/Pages/PageTheme.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with AutomaticKeepAliveClientMixin {
  int tabIndex = 0;
  late List<int> weeklyData;
  List<int> monthlyData = [];
  List<int> yearlyData = [];
  @override
  void initState() {
    super.initState();
    weeklyData = History.instance.getWeekdayCount();
    History.instance.addListener(_onHistoryChanged);
  }

  void _onHistoryChanged() {
    if (tabIndex == 0) {
      weeklyData = History.instance.getWeekdayCount();
    } else if (tabIndex == 1) {
      monthlyData = History.instance.getMonthlyCount();
    } else {
      yearlyData = History.instance.getYearlyCount();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<int> data = tabIndex == 0
        ? weeklyData
        : (tabIndex == 1 ? monthlyData : yearlyData);
    return PageTheme(
      content: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StaticContainer(
              padding: MediaQuery.of(context).size.width * 0.02,
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.4,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoScaleText(
                    text: "Usage Trends",
                    align: TextAlign.start,
                    weight: FontWeight.w400,
                    maxLines: 1,
                    maxSize: 16,
                  ),
                  const SizedBox(height: 8),
                  AutoScaleText(
                    text:
                        "${tabIndex == 0 ? "${History.instance.weeklyCount} this week" :
                         (tabIndex == 1 ? "${History.instance.monthlyCount} this month":
                        "${History.instance.yearlyCount} this year")} ",
                    align: TextAlign.start,
                    weight: FontWeight.w600,
                    maxLines: 1,
                    maxSize: 23,
                  ),
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: HistoryLineChart(
                      data: data,
                      mode: tabIndex == 0
                          ? "weekly"
                          : (tabIndex == 1 ? "monthly" : "yearly"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
