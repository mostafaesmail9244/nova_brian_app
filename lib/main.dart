import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/cache_helper.dart';
import 'package:nova_brian_app/core/routes/app_router.dart';
import 'package:nova_brian_app/core/routes/routes.dart';
import 'package:nova_brian_app/core/theme/app_colors.dart';
import 'package:nova_brian_app/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColors.darkGrey));

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MaterialApp(
        title: 'Nova Brian App',
        onGenerateRoute: AppRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashRoute,
        // theme: CacheHelper.getData(key: Constants.themeMode) == true
        //     ? AppTheme.darkTheme
        //     : AppTheme.lightTheme,
      ),
    );
  }
}

// API key  => AIzaSyBW2jlX-c_PKjL1l9gwW_hFa8iVFwS7WU4
