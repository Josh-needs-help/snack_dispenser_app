import 'package:firebase_database/firebase_database.dart';
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

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  late int dispenserUses;
  late int dispenserUsesToday;
  List<HistoryEntry> historyList = History.instance.getLastEntries();
  @override
  void initState() {
    super.initState();
    dispenserUses = History.instance.data.length;
    dispenserUsesToday = History.instance.calculateTodayUsage();
    History.instance.addListener(_onHistoryChanged);
  }

  void _onHistoryChanged() {
    dispenserUses = History.instance.data.length;
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
         /* IconButton(
            onPressed: () async {
              final ref = FirebaseDatabase.instance.ref('history');

                final now = DateTime.now();

                await ref.push().set({
                  'name': 'Test Snack',
                  'date':
                      '${now.year},${now.month},${now.day},${now.hour},${now.minute},${now.second}',
                  'timestamp': now.millisecondsSinceEpoch,
                });
            },
            icon: const Icon(Icons.plus_one),
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
