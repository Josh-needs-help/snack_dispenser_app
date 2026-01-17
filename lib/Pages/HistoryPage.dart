
import 'package:flutter/material.dart';
import 'package:snack_dispenser_app/Components/AutoScaleText.dart';
import 'package:snack_dispenser_app/Components/HistoryTile.dart';
import 'package:snack_dispenser_app/Components/StaticContainer.dart';
import 'package:snack_dispenser_app/Models/History.dart';
import 'package:snack_dispenser_app/Models/HistoryEntry.dart';
import 'package:snack_dispenser_app/Pages/PageTheme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with AutomaticKeepAliveClientMixin {
  late int dispenserUses = 0; //placeholder
  late int dispenserUsesToday = 0; //placeholder
  List<HistoryEntry> historyList = History.instance.getLastEntries();
  @override
  void initState() {
    super.initState();
    dispenserUses = 0;
    dispenserUsesToday = 0;
    History.instance.addListener(_onHistoryChanged);
  }

  void _onHistoryChanged() {
    historyList = History.instance.getLastEntries();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double padding = MediaQuery.of(context).size.width * 0.02;
    return PageTheme(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: StaticContainer(
              padding: padding,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.18,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoScaleText(
                    text: "Dispenser Used",
                    align: TextAlign.center,
                    weight: FontWeight.w300,
                    maxLines: 1,
                    maxSize: 14,
                  ),
                  AutoScaleText(
                    text: "$dispenserUses times",
                    align: TextAlign.center,
                    weight: FontWeight.bold,
                    maxLines: 1,
                    maxSize: 50,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Center(
            child: StaticContainer(
              padding: padding,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.10,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoScaleText(
                    text: "Today's Usage: $dispenserUsesToday",
                    align: TextAlign.center,
                    weight: FontWeight.bold,
                    maxLines: 1,
                    maxSize: 20,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: AutoScaleText(
                  text: "Recent History",
                  weight: FontWeight.bold,
                  maxSize: 20,
                  align: TextAlign.start,
                ),
              ),
            ],
          ),
          // for testing purposes
          /*IconButton(
            onPressed: () async {
              final _ref = FirebaseDatabase.instance.ref('history');

              int year = 2026;
              int month = 1; // January

              for (int i = 0; i < 20; i++) {
                int day = (i % 31) + 1; // day 1–31
                int hour = (i * 3) % 24;
                int minute = (i * 7) % 60;
                int second = (i * 11) % 60;

                int timestamp = DateTime.now().millisecondsSinceEpoch;

                await _ref.push().set({
                  'name': "Test Snack #$i",
                  'date': "$year,$month,$day,$hour,$minute,$second",
                  'timestamp': timestamp,
                });
              }
            },
            icon: Icon(Icons.plus_one),
          ),*/
          Expanded(
            child: ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final entry = historyList[index];
                return Column(
                  children: [
                    SizedBox(height: 10),
                    HistoryTile(
                      entry: entry,
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
