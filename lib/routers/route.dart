import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/screens/editviocation.dart';
import 'package:eduappui/screens/historyviolation.dart';
import 'package:eduappui/screens/login.dart';
import 'package:eduappui/screens/main_screen.dart';
import 'package:eduappui/screens/notifications.dart';
import 'package:eduappui/screens/setting.dart';
import 'package:eduappui/screens/splash.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: ScreenRoute.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: ScreenRoute.splash,
        builder: (context, state) => Splash(),
      ),
      GoRoute(
        path: ScreenRoute.loginScreen,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: ScreenRoute.homeScreen,
        builder: (context, state) => MainScreen(),
      ),
      GoRoute(
        path: ScreenRoute.violationHistoryScreen,
        builder: (context, state) => HistoryScreen(),
      ),
      GoRoute(
        path: ScreenRoute.violationEditScreen,
        builder: (context, state) {
          final args = state.extra;
          final id = (args as Map<String, dynamic>)['id'];
          return Editviocation(id: id);
        },
      ),
      GoRoute(
        path: ScreenRoute.notificationPage,
        builder: (context, state) => NotificationScreen(),
      ),
      GoRoute(
        path: ScreenRoute.settingsScreen,
        builder: (context, state) => SettingsScreen(),
      ),
    ],
  );
  static GoRouter get router => _router;
}
