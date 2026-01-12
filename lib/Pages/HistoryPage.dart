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
class _HistoryPageState extends State<HistoryPage> {
  late int dispenserUses = 0; //placeholder
  late int dispenserUsesToday = 0; //placeholder
  List<HistoryEntry> historyList = History.instance.data;
  @override
  void initState() {
    super.initState();
    dispenserUses = 0;
    dispenserUsesToday = 0;
    History.instance.addListener(_onHistoryChanged);
  }
   void _onHistoryChanged() {
    setState(() {}); 
  }
  @override
  Widget build(BuildContext context) {
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
              SizedBox(width: MediaQuery.of(context).size.width * 0.025,),
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
            onPressed: (){
              final _ref = FirebaseDatabase.instance.ref('history');
              int time = DateTime.now().millisecondsSinceEpoch;
              _ref.push().set({
                'name': "Big snack",
                'date': "2005,10,3,10,12,45",
                'timestamp': time,
              });
            }
          , icon: Icon(Icons.plus_one)
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
}
