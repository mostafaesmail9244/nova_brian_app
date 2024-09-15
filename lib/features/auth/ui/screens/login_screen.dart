import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/core/helper/spacing.dart';
import 'package:nova_brian_app/core/routes/routes.dart';
import 'package:nova_brian_app/features/auth/ui/widgets/login_button.dart';
import 'package:nova_brian_app/features/auth/ui/widgets/login_forms.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  'Sign In',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                verticalSpace(20),
                const LoginForms(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        context.pushNamed(Routes.forgetPassRoute);
                      },
                      child: const Text('Forgot Password?')),
                ),
                verticalSpace(15),

                const LoginButton(),
                verticalSpace(20),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pushReplacmentNamed(Routes.signUpRoute);
                          },
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // TODO: add bloc listener here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
