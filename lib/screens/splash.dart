import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:eduappui/remote/constant/constants.dart';
import 'package:eduappui/remote/local/local_client.dart';
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
    final localClient = LocalClientImpl();

    final accessToken = await secureStorage.getAccessToken();
    final expiredAt = localClient.readData(Constants.expired_at);

    if (expiredAt == null || DateTime.now().isAfter(convertTimestampToDate(expiredAt))) {
      await secureStorage.removeAllAsync();
      await localClient.removeAll();
      if (mounted) {
        context.pushReplacement(ScreenRoute.loginScreen);
      }
      return;
    }

    if (mounted) {
      final targetScreen = (accessToken != null) ? ScreenRoute.homeScreen : ScreenRoute.loginScreen;
      context.pushReplacement(targetScreen);
    }
  }

  DateTime convertTimestampToDate(String timestamp) {
    // Convert the Unix timestamp (in seconds) to a DateTime object
    return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
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
