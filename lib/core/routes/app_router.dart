import 'package:flutter/material.dart';
import 'package:nova_brian_app/core/routes/routes.dart';
import 'package:nova_brian_app/features/auth/ui/screens/login_screen.dart';
import 'package:nova_brian_app/features/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      default:
        return null;
    }
  }
}
