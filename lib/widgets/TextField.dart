import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Icon? fieldicon;
  final TextEditingController? controller;

  const CustomTextField({this.hintText, this.fieldicon, this.controller});

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
        fillColor: Color(0XFFF5F6F8),
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
