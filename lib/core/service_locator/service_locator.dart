import 'package:get_it/get_it.dart';
import 'package:nova_brian_app/features/auth/data/repo/auth_repo.dart';

GetIt getIt = GetIt.instance;

void setubGetIt() async {
  
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
}
