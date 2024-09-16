import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_brian_app/core/constants/app_assets.dart';
import 'package:nova_brian_app/core/constants/constants.dart';
import 'package:nova_brian_app/core/helper/app_regex.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';
import 'package:nova_brian_app/core/helper/spacing.dart';
import 'package:nova_brian_app/core/shared/custom_button.dart';
import 'package:nova_brian_app/core/shared/custom_loading_widget.dart';
import 'package:nova_brian_app/core/shared/custom_text_form_field.dart';
import 'package:nova_brian_app/features/auth/logic/forget_pass/forget_pass_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: Constants.defaultPadding,
        child: SingleChildScrollView(
          child: Form(
            key: context.read<ForgetPassCubit>().formKey,
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
                    textInputAction: TextInputAction.done,
                    autoFill: const [AutofillHints.email],
                    controller:
                        context.read<ForgetPassCubit>().forgetPassController,
                    validator: (val) {
                      if (val!.isEmpty || !AppRegex.isEmailValid(val)) {
                        return 'Please Enter Valid Email';
                      }
                    }),
                verticalSpace(20),
                CustomButton(
                  text: 'Send',
                  onPressed: () {
                    if (context
                        .read<ForgetPassCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<ForgetPassCubit>().forgetPassword();
                    }
                  },
                ),
                const ForgetPassBlocListener(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ForgetPassBlocListener extends StatelessWidget {
  const ForgetPassBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPassCubit, ForgetPassState>(
      listener: (context, state) {
        if (state is ForgetPassSuccessState) {
          context.pop();
          context.showSnackBar('Check your email for reset password');

          context.pop();
        } else if (state is ForgetPassErrorState) {
          context.pop();
          context.showSnackBar(state.error);
        } else if (state is ForgetPassLoadingState) {
          customLoading(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
