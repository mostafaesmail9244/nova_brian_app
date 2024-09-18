import 'package:flutter/material.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/cache_helper.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool ?isLogin;
  @override
  initState() {
    navigatToOnBoard(context);
    isLogin = CacheHelper.getData(key: Constants.uId) != null ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.black : Colors.white,
      body: Center(child: Image.asset(AppAssets.logo)),
    );
  }

  void navigatToOnBoard(context) async {
    Duration duration = const Duration(seconds: 1);
    await Future.delayed(duration);
    Navigator.pushReplacementNamed(
        context, isLogin! ? Routes.homeRoute : Routes.loginRoute);
  }
}
