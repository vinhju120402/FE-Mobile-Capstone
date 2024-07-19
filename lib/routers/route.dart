import 'package:eduappui/remote/local/secure_storage.dart';
import 'package:eduappui/routers/screen_route.dart';
import 'package:eduappui/screens/contact.dart';
import 'package:eduappui/screens/create_violation_screen.dart';
import 'package:eduappui/screens/duty.dart';
import 'package:eduappui/screens/editviocation.dart';
import 'package:eduappui/screens/historyviolation.dart';
import 'package:eduappui/screens/login.dart';
import 'package:eduappui/screens/main_screen.dart';
import 'package:eduappui/screens/notifications.dart';
import 'package:eduappui/screens/profile.dart';
import 'package:eduappui/screens/rule.dart';
import 'package:eduappui/screens/setting.dart';
import 'package:eduappui/screens/splash.dart';
import 'package:eduappui/screens/term.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: ScreenRoute.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      if (ScreenRoute.publicRoute.contains(state.fullPath)) {
        return null;
      }
      final secureStorage = SecureStorageImpl();
      final accessToken = await secureStorage.getAccessToken();

      if (accessToken != null) {
        return null;
      } else {
        return ScreenRoute.loginScreen;
      }
    },
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
      GoRoute(
        path: ScreenRoute.profileScreen,
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: ScreenRoute.ruleScreen,
        builder: (context, state) => RuleScreen(),
      ),
      GoRoute(
        path: ScreenRoute.createViolationScreen,
        builder: (context, state) => CreateViolationScreen(),
      ),
      GoRoute(
        path: ScreenRoute.contactScreen,
        builder: (context, state) => ContactScreen(),
      ),
      GoRoute(
        path: ScreenRoute.dutyScheduleScreen,
        builder: (context, state) => DutyScheduleScreen(),
      ),
      GoRoute(
        path: ScreenRoute.termScreen,
        builder: (context, state) => TermsScreen(),
      ),
    ],
  );
  static GoRouter get router => _router;
}
