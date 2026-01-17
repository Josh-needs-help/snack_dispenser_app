import 'package:flutter/material.dart';

class StaticContainer extends StatelessWidget {
  final double padding;
  final double width;
  final double height;
  final Widget content;
  const StaticContainer({
    super.key,
    required this.padding,
    required this.width,
    required this.height,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(128, 32, 54, 58),
      ),
      padding: EdgeInsets.fromLTRB(2 * padding, padding, 2 * padding, padding),
      width: width,
      height: height,
      child: content,
    );
  }
}
