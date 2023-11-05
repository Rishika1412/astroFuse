import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    title: const Text(
      'AstroFuse',
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
    ),
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.wallet, size: 25)),
      IconButton(onPressed: () {}, icon: Icon(Icons.language, size: 25)),
      IconButton(onPressed: () {}, icon: Icon(Icons.help_center, size: 25)),
    ],
  );
}
