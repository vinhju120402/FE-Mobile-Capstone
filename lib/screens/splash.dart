import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Splash Init");
      },
      onEnd: () {
        debugPrint("On Splash End");
        context.pushReplacement(ScreenRoute.loginScreen);
      },
      duration: const Duration(seconds: 3),
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset("images/logo.jpg"),
      ),
    );
  }
}
