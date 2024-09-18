import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_brian_app/core/routes/routes.dart';
import 'package:nova_brian_app/core/service_locator/service_locator.dart';
import 'package:nova_brian_app/features/auth/data/repo/auth_repo.dart';
import 'package:nova_brian_app/features/auth/logic/forget_pass/forget_pass_cubit.dart';
import 'package:nova_brian_app/features/auth/logic/login/login_cubit.dart';
import 'package:nova_brian_app/features/auth/logic/register/register_cubit.dart';
import 'package:nova_brian_app/features/auth/ui/screens/forget_pass_screen.dart';
import 'package:nova_brian_app/features/auth/ui/screens/login_screen.dart';
import 'package:nova_brian_app/features/auth/ui/screens/sign_up_screen.dart';
import 'package:nova_brian_app/features/home/data/models/user_model.dart';
import 'package:nova_brian_app/features/home/data/service/gemini_services.dart';
import 'package:nova_brian_app/features/home/logic/cubit/chat_cubit.dart';
import 'package:nova_brian_app/features/home/ui/screens/home_screen.dart';
import 'package:nova_brian_app/features/settings/ui/screens/settings_screen.dart';
import 'package:nova_brian_app/features/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.settingsRoute:
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (context) => SettingsScreen(user: user));
      case Routes.homeRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      ChatCubit(getIt<GeminiService>())..getUserData(),
                  child: const HomeScreen(),
                ));
      case Routes.forgetPassRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ForgetPassCubit(getIt<AuthRepository>()),
                  child: const ForgetPasswordScreen(),
                ));
      case Routes.loginRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => LoginCubit(getIt<AuthRepository>()),
                  child: const LoginScreen(),
                ));
      case Routes.signUpRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => RegisterCubit(getIt<AuthRepository>()),
                  child: const SignUpScreen(),
                ));
      default:
        return null;
    }
  }
}
