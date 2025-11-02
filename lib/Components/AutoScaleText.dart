import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoScaleText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double? maxSize;
  final double? minSize;
  final TextAlign align;
  final bool? bold;
  final Color? color;
  const AutoScaleText({
    super.key,
    required this.text,
    this.maxLines,
    this.maxSize,
    this.minSize,
    required this.align,
    this.color, this.bold,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        color: color??const Color.fromARGB(255, 223, 223, 223),
        fontWeight: bold!=null&&bold==true?FontWeight.bold:FontWeight.w500,
        fontSize: maxSize??300
      ),
      maxLines: maxLines ?? 3,
      minFontSize: minSize ?? 10,
      textAlign: align,
    );
  }
}
