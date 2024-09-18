import 'package:get_it/get_it.dart';
import 'package:nova_brian_app/features/auth/data/repo/auth_repo.dart';
import 'package:nova_brian_app/features/home/data/service/gemini_services.dart';

GetIt getIt = GetIt.instance;

void setubGetIt() async {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<GeminiService>(() => GeminiService());
}
