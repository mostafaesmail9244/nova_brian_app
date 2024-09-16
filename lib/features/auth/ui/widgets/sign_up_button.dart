import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/features/auth/logic/register/register_cubit.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: context.deviceWidth * 0.8,
      child: ElevatedButton(
        onPressed: () async {
          if (context.read<RegisterCubit>().formKey.currentState!.validate()) {
            context.read<RegisterCubit>().signUp();
          }
        },
        child: Text(
          'SignUp',
          style: TextStyle(
            color: context.isDarkMode ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
