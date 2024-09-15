import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/core/helper/spacing.dart';
import 'package:nova_brian_app/core/routes/routes.dart';
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
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                verticalSpace(20),
                const SignUpForms(),
                verticalSpace(15),
                const SignUpButton(),
                verticalSpace(20),
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.black),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
