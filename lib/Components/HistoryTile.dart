import 'package:flutter/material.dart';
import 'package:snack_dispenser_app/Components/AutoScaleText.dart';
import 'package:snack_dispenser_app/Models/HistoryEntry.dart';

class HistoryTile extends StatelessWidget {
  final HistoryEntry entry;
  final double width;
  final double height;
  const HistoryTile({
    super.key,
    required this.entry,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 25, 34, 49),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: height * 0.9,
            height: height * 0.9,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.fastfood,
              color: Colors.lightBlue,
              size: height * 0.7,
            ),
          ),
          SizedBox(width: width * 0.1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoScaleText(
                  text: entry.name,
                  align: TextAlign.start,
                  maxLines: 1,
                  weight: FontWeight.bold,
                  maxSize: 20,
                ),
                AutoScaleText(
                  align: TextAlign.start,
                  weight: FontWeight.w300,
                  text:
                      entry.toString(),
                  maxLines: 1,
                  maxSize: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
