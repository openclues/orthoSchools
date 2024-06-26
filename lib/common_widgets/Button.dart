import 'package:azsoon/Core/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Function()? onpress;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Widget? widget;
  final Color? textColor;
  const CustomButton(
      {super.key, this.buttonText,
      this.widget,
      this.buttonColor,
      this.borderColor,
      this.textColor,
      this.onpress,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      height: height,
      minWidth: width,
      color: buttonColor ?? primaryColor,
      textColor: textColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: borderColor ??
              const Color(0XFF8174CC), // Use default if not provided
        ),
      ),
      onPressed: onpress,
      child: widget ?? Text(
              buttonText!,
              style: const TextStyle(fontSize: 18.0),
            ),
    );
  }
}
