import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nova_brian_app/core/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final TextInputType? inputType;
  final bool? isObsecureText;
  final Function(String?)? validator;
  final Widget? sufficIcon;
  final Iterable<String>? autoFill;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final String hintText;
  final Color? backGroundColor;
  const CustomTextFormField(
      {super.key,
      this.enabledBorder,
      this.textInputAction,
      this.focusedBorder,
      this.controller,
      this.hintStyle,
      this.maxLines,
      this.padding,
      this.inputType,
      this.isObsecureText,
      this.validator,
      this.sufficIcon,
      required this.hintText,
      this.prefixIcon,
      this.backGroundColor,
      this.autoFill});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, textInputAction: textInputAction,
      maxLines: maxLines ?? 1,
      autofillHints: autoFill,
      obscureText: isObsecureText ?? false,
      decoration: InputDecoration(
        isDense: true,
        prefix: prefixIcon,
        filled: true,
        fillColor: backGroundColor ?? Colors.transparent,
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding:
            padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        suffixIcon: sufficIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.3),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: enabledBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey, width: 1.3),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
        focusedBorder: focusedBorder ??
            const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.3),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
      ),
      keyboardType: inputType ?? TextInputType.text,
      // style: TextStyles.font14DarkBlueMedium,
      validator: (value) {
        return validator!(value);
      },
    );
  }
}
