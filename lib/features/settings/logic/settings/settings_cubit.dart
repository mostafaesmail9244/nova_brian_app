import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/cache_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  bool isDark = CacheHelper.getData(key: Constants.themeMode) ?? false;

  void changeThemeMode() {
    isDark = !isDark;

    Logger().d('Theme mode changed: $isDark');
    CacheHelper.put(
      key: Constants.themeMode,
      value: isDark,
    ).then((value) {
      emit(ChangeThemeState());
    });
  }
}
