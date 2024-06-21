import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/screens/editviocation.dart';
import 'package:eduappui/screens/historyviolation.dart';
import 'package:eduappui/screens/login.dart';
import 'package:eduappui/screens/main_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: ScreenRoute.loginScreen,
    debugLogDiagnostics: true,
    routes: [
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
    ],
  );
  static GoRouter get router => _router;
}
