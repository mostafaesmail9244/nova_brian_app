import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/features/auth/logic/login/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: context.deviceWidth * 0.8,
      child: ElevatedButton(
        onPressed: () async {
          if (context.read<LoginCubit>().formKey.currentState!.validate()) {
            context.read<LoginCubit>().login();
          }
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: context.isDarkMode ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
