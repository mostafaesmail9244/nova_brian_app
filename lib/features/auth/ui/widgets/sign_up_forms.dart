import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_brian_app/core/helper/app_regex.dart';
import 'package:nova_brian_app/core/helper/spacing.dart';
import 'package:nova_brian_app/core/shared/custom_text_form_field.dart';
import 'package:nova_brian_app/features/auth/logic/register/register_cubit.dart';

class SignUpForms extends StatelessWidget {
  const SignUpForms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: 'Enter Your Name',
            validator: (val) {
              if (val!.isEmpty || val.length < 8) {
                return 'Please Enter Valid Name';
              }
              return null;
            },
            inputType: TextInputType.text,
            controller: context.read<RegisterCubit>().nameController,
            autoFill: const [AutofillHints.name],
          ),
          verticalSpace(20),
          CustomTextFormField(
            hintText: 'Enter Your Email',
            validator: (val) {
              if (val!.isEmpty || !AppRegex.isEmailValid(val)) {
                return 'Please Enter Valid Email';
              }
              return null;
            },
            inputType: TextInputType.emailAddress,
            controller: context.read<RegisterCubit>().emailController,
            autoFill: const [AutofillHints.email],
          ),
          verticalSpace(20),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return CustomTextFormField(
                hintText: 'Enter Your Password',
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please Enter Valid Password';
                  }
                  return null;
                },
                controller: context.read<RegisterCubit>().passwordController,
                isObsecureText: context.read<RegisterCubit>().isObscure,
                sufficIcon: IconButton(
                  onPressed: () {
                    context.read<RegisterCubit>().changeVisibility();
                  },
                  icon: Icon(context.read<RegisterCubit>().isObscure
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
