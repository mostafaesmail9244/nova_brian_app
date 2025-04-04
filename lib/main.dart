import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nova_brian_app/bloc_observer.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/cache_helper.dart';
import 'package:nova_brian_app/core/routes/app_router.dart';
import 'package:nova_brian_app/core/routes/routes.dart';
import 'package:nova_brian_app/core/service_locator/service_locator.dart';
import 'package:nova_brian_app/core/theme/app_colors.dart';
import 'package:nova_brian_app/core/theme/app_theme.dart';
import 'package:nova_brian_app/features/settings/logic/settings/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: Constants.apiKey);
  await CacheHelper.init();
  await ScreenUtil.ensureScreenSize();
  setubGetIt();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColors.darkGrey));
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
              title: 'Nova Brian App',
              onGenerateRoute: AppRouter.onGenerateRoute,
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splashRoute,
              theme: CacheHelper.getData(key: Constants.themeMode) == true
                  ? AppTheme.darkTheme
                  : AppTheme.lightTheme,
            ),
          );
        },
      ),
    );
  }
}
