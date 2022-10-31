import 'package:flutter/material.dart';
import 'package:paper_clip_assignment/screens/main_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'paper clip assignment',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MainUI(),
    );
  }
}