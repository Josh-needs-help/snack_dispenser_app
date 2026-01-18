import 'package:flutter/material.dart';

class PageTheme extends StatefulWidget {
  final Widget content;
  const PageTheme({super.key,required this.content});

  @override
  State<PageTheme> createState() => _PageThemeState();
}

class _PageThemeState extends State<PageTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 28, 31),
      body: widget.content
    );
  }
}