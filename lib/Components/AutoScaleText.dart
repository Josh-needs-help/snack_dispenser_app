import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoScaleText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double? maxSize;
  final double? minSize;
  final TextAlign align;
  final Color? color;
  final FontWeight weight;
  const AutoScaleText({
    super.key,
    required this.text,
    this.maxLines,
    this.maxSize,
    this.minSize,
    required this.align,
    this.color, required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        color: color??const Color.fromARGB(255, 223, 223, 223),
        fontWeight: weight,
        fontSize: maxSize??300
      ),
      maxLines: maxLines ?? 3,
      minFontSize: minSize ?? 10,
      textAlign: align,
    );
  }
}
