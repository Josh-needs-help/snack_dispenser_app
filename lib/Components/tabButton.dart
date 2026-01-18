import 'package:flutter/material.dart';
import 'package:snack_dispenser_app/Components/AutoScaleText.dart';

class TabButton extends StatefulWidget {
  final bool isPressed;
  final void Function(int) onPress;
  final int index;
  const TabButton({
    super.key,
    required this.isPressed,
    required this.onPress,
    required this.index,
  });

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          widget.isPressed
              ? Colors.blue
              : Color.fromARGB(255, 25, 34, 49),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), 
          ),
        ),
      ),
      onPressed: () {
        widget.onPress(widget.index);
      },
      child: AutoScaleText(
        text: widget.index == 0
            ? "Weekly"
            : (widget.index == 1 ? "Monthly" : "Yearly"),
        align: TextAlign.center,
        weight: FontWeight.w500,
        maxLines: 1,
        maxSize: 20,
      ),
    );
  }
}
