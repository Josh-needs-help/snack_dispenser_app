import 'package:flutter/material.dart';
import 'package:snack_dispenser_app/Components/tabButton.dart';

class TabSwitcher extends StatefulWidget {
  final void Function(int) onPress;
  final double width;
  final double height;
  const TabSwitcher({
    super.key,
    required this.onPress,
    required this.width,
    required this.height,
  });

  @override
  State<TabSwitcher> createState() => _TabSwitcherState();
}

class _TabSwitcherState extends State<TabSwitcher> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TabButton(
                onPress: (i) {
                  setState(() => selected = i);
                  widget.onPress(i);
                },
                index: index,
                isPressed: index == selected,
              ),
            ),
          );
        }),
      ),
    );
  }
}
