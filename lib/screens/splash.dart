import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:eduappui/remote/local/secure_storage.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _handleEndSplash() async {
    debugPrint("On Splash End");
    final secureStorage = SecureStorageImpl();
    final accessToken = await secureStorage.getAccessToken();
    if (!mounted) return; // Check if the widget is still mounted
    if (accessToken != null) {
      context.pushReplacement(ScreenRoute.homeScreen);
    } else {
      context.pushReplacement(ScreenRoute.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Splash Init");
      },
      onEnd: () async {
        await _handleEndSplash();
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
