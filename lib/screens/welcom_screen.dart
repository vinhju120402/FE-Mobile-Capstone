import 'dart:async';

import 'package:eduappui/screens/login.dart';
import 'package:flutter/material.dart';

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({Key? key}) : super(key: key);

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  @override
  void initState() {
    super.initState();
    // Sau 2 giây, chuyển qua màn hình đăng nhập
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // ignore: prefer_const_constructors
      color: Color.fromARGB(190, 6, 231, 231),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipOval(
              child: Image.asset(
                "images/logo.jpg", // Replace "logo.png" with your logo image asset path
                scale: 8,
              ),
            ),
          ),
          const SizedBox(
              height: 20), // Add some space between the image and text
          const Text(
            'SAO ĐỎ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
