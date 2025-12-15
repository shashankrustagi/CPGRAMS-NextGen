import 'package:flutter/material.dart';

import '../screens/splash/splash_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/grievance/file_grievance_screen.dart';
import '../screens/grievance/grievance_list_screen.dart';
import '../screens/grievance/grievance_detail_screen.dart';
import '../screens/profile/profile_screen.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String fileGrievance = '/file-grievance';
  static const String grievanceList = '/grievance-list';
  static const String grievanceDetail = '/grievance-detail';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case fileGrievance:
        return MaterialPageRoute(builder: (_) => const FileGrievanceScreen());
      case grievanceList:
        return MaterialPageRoute(builder: (_) => const GrievanceListScreen());
      case grievanceDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => GrievanceDetailScreen(
            grievanceId: args?['id'] ?? '',
          ),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
