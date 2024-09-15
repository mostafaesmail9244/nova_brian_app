import 'package:flutter/material.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/app_regex.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/core/helper/spacing.dart';
import 'package:nova_brian_app/core/shared/custom_button.dart';
import 'package:nova_brian_app/core/shared/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: Constants.defaultPadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: context.deviceHeight * 0.1),
              Image.asset(AppAssets.message),
              verticalSpace(40),
              const Text(
                'Forget Password',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              verticalSpace(20),
              const Text(
                'Enter your email and we will send \nyou a link to reset your password',
                textAlign: TextAlign.center,
              ),
              verticalSpace(40),
              CustomTextFormField(
                  hintText: 'Enter Your Email',
                  validator: (val) {
                    if (val!.isEmpty || !AppRegex.isEmailValid(val)) {
                      return 'Please Enter Valid Email';
                    }
                  }),
              verticalSpace(20),
              CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  })
            ],
          ),
        ),
      )),
    );
  }
}
