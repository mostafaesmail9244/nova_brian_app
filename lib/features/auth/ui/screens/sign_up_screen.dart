import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/core/helper/spacing.dart';
import 'package:nova_brian_app/core/routes/routes.dart';
import 'package:nova_brian_app/core/shared/custom_loading_widget.dart';
import 'package:nova_brian_app/core/theme/app_colors.dart';
import 'package:nova_brian_app/features/auth/logic/register/register_cubit.dart';
import 'package:nova_brian_app/features/auth/ui/widgets/sign_up_button.dart';
import 'package:nova_brian_app/features/auth/ui/widgets/sign_up_forms.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Constants.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: context.deviceHeight * 0.1),
                Image.asset(AppAssets.wave),
                verticalSpace(40),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                verticalSpace(20),
                const SignUpForms(),
                verticalSpace(15),
                const SignUpButton(),
                verticalSpace(20),
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                        color:
                            context.isDarkMode ? AppColors.grey : Colors.black),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pushReplacmentNamed(Routes.loginRoute);
                          },
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const RegisterBlocListener()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          context.pop();

          // context.pushReplacmentNamed(Routes.homeRoute);
        } else if (state is RegisterErrorState) {
          context.pop();

          context.showSnackBar(state.error);
        } else if (state is RegisterLoadingState) {
          customLoading(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
