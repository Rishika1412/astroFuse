import 'package:astrofuseui/views/main_screen.dart';
import 'package:flutter/material.dart';

import 'components/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AstroFuse',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appcolor),
        useMaterial3: true,
      ),
      home:const MainScreen(),
    );
  }
}

