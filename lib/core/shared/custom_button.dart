import 'package:flutter/material.dart';
import 'package:nova_brian_app/core/helper/extentions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.onPressed, this.textStyle, required this.text});
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: context.deviceWidth * 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                color: context.isDarkMode ? Colors.black : Colors.white,
              ),
        ),
      ),
    );
  }
}
