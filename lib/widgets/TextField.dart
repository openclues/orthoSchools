import 'package:flutter/material.dart';
import 'package:azsoon/Constants.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Icon? fieldicon;
  final Color? textfiledColor;
  final TextEditingController? controller;
  final Color borderColor;

  const CustomTextField(
      {super.key,
      this.hintText,
      this.labelText,
      this.fieldicon,
      this.controller,
      this.textfiledColor,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              labelText!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          TextField(
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
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(11.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//e-mail address
//Icon(Icons.email, color: Color(0XFF939199), size: 15),
