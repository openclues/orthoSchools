import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Function()? onpress;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Color? textColor;
  const CustomButton(
      {this.buttonText,
      this.buttonColor,
      this.borderColor,
      this.textColor,
      this.onpress,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: buttonColor,
      textColor: textColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          color:
              borderColor ?? Color(0XFF8174CC), // Use default if not provided
        ),
      ),
      onPressed: onpress,
      child: Text(
        buttonText!,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
