import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  const CustomButton({this.buttonText, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 43,
      color: buttonColor,
      textColor: Colors.white,
      onPressed: () {},
      child: Text(buttonText!),
    );
  }
}
