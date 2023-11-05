import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  final String screenName;
  const Screen({super.key, required this.screenName});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        '${widget.screenName} Screen',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      )),
    );
  }
}
