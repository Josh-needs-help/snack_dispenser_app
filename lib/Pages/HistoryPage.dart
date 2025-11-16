import 'package:flutter/material.dart';
import 'package:snack_dispenser_app/Components/AutoScaleText.dart';
import 'package:snack_dispenser_app/Components/StaticContainer.dart';
import 'package:snack_dispenser_app/Pages/PageTheme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late int dispenserUses = 0; //placeholder
  late int dispenserUsesToday = 0;//placeholder
  @override
  void initState() {
    super.initState();
    dispenserUses = 0;
    dispenserUsesToday = 0;
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
                    bold: false,
                    maxLines: 1,
                    maxSize: 14,
                  ),
                  AutoScaleText(
                    text: "$dispenserUses times",
                    align: TextAlign.center,
                    bold: true,
                    maxLines: 1,
                    maxSize: 50,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height:MediaQuery.of(context).size.height * 0.05,),
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
                    bold: false,
                    maxLines: 1,
                    maxSize: 20,
                  ),
                ],
              ),
            ),
          ),
          //next thing to work on. Listview.
        ],
      ),
    );
  }
}
