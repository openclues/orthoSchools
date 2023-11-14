import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Function()? onpress;
  final double? width;
  final double? height;
  const CustomButton(
      {this.buttonText,
      this.buttonColor,
      this.onpress,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: buttonColor,
      textColor: Colors.white,
      onPressed: onpress,
      child: Text(buttonText!),
    );
  }
}
