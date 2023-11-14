import 'package:flutter/material.dart';
import 'package:azsoon/Constants.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Icon? fieldicon;
  final Color? textfiledColor;
  final TextEditingController? controller;

  const CustomTextField(
      {this.hintText, this.fieldicon, this.controller, this.textfiledColor});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: fieldicon,
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0XFF939199)),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        filled: true,
        fillColor: textfiledColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11.0),
          borderSide: BorderSide(
            color: Color(0XFFF5F6F8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0XFFF5F6F8),
          ), // Change color here
        ),
      ),
    );
  }
}

//e-mail address
//Icon(Icons.email, color: Color(0XFF939199), size: 15),
