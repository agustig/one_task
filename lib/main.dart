import 'package:flutter/material.dart';
import 'package:one_task/theme.dart';
import 'package:one_task/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1Task',
      theme: oneTaskTheme(),
      home: const Home(),
    );
  }
}
