// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/cache_helper.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/core/helper/spacing.dart';
import 'package:nova_brian_app/core/routes/routes.dart';
import 'package:nova_brian_app/features/home/data/models/user_model.dart';
import 'package:nova_brian_app/features/settings/logic/settings/settings_cubit.dart';
import 'package:nova_brian_app/features/settings/ui/widgets/list_tile_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.user,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: Constants.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account',
                  style: TextStyle(
                      color: context.isDarkMode ? Colors.white : Colors.grey),
                ),
                verticalSpace(10),
                ListTileItem(
                    title: 'Name', subTitle: user.name, icon: Icons.person),
                verticalSpace(10),
                ListTileItem(
                    title: 'Email', subTitle: user.email, icon: Icons.email),
                verticalSpace(20),
                Text(
                  'APP',
                  style: TextStyle(
                      color: context.isDarkMode ? Colors.white : Colors.grey),
                ),
                verticalSpace(10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: context.isDarkMode
                        ? Colors.grey.shade700
                        : Colors.white,
                  ),
                  child: BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return SwitchListTile(
                        value: context.read<SettingsCubit>().isDark,
                        onChanged: (val) {
                          context.read<SettingsCubit>().changeThemeMode();
                        },
                        title: Text(
                          'Dark Mode',
                          style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      );
                    },
                  ),
                ),
                verticalSpace(20),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        logOut(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.isDarkMode
                            ? Colors.grey.shade700
                            : Colors.white,
                      ),
                      label: const Text('Logout',
                          style: TextStyle(
                            color: Colors.red,
                          )),
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logOut(BuildContext context) {
    CacheHelper.removeData(key: Constants.uId).then((val) {
      context.pushReplacmentNamed(Routes.loginRoute);
    });
  }
}
