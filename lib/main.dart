import 'package:eduappui/screens/home_screen.dart';
import 'package:eduappui/screens/main_screen.dart';
import 'package:eduappui/screens/welcom_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Ẩn chữ "DEBUG"
      home: const WelcomScreen(),
    );
  }
}
