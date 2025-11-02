import 'package:flutter/material.dart';
import 'package:snack_dispenser_app/Components/AutoScaleText.dart';
import 'package:snack_dispenser_app/Pages/PageTheme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late int dispenserUses = 0; //placeholder
  @override
  void initState() {
    super.initState();
    dispenserUses = 0; 
  }

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.width * 0.02;
    return PageTheme(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(padding),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.2,
            color: Color(0xFF1F2937),
            child: Center(
              child: AutoScaleText(
                text: "Dispenser has been used $dispenserUses times today",
                align: TextAlign.center,
                bold:true,
                maxLines: 1,
                maxSize: 600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
