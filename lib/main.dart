import 'package:divyanga/screens/home_screen.dart';
import 'package:divyanga/screens/paint_screen.dart';
import 'package:divyanga/screens/report_screen.dart';
import 'package:divyanga/screens/speechText_screen.dart';
import 'package:divyanga/screens/traceLetter_screen.dart';
import 'package:divyanga/screens/userDetails_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Paint_Screen(),
    );
  }
}
