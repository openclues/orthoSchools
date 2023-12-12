import 'package:flutter/material.dart';
import 'package:azsoon/Utils/Constants.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Icon? fieldicon;
  void Function(String?)? onSaved;
  final IconButton? iconButton;
  final Color? textfiledColor;
  final TextEditingController? controller;
  final Color borderColor;
  final bool obscureText;
  String? initialValue;
  final int? maxLines;
  // final String? intialValue;

  CustomTextField(
      {super.key,
      this.hintText,
      this.onSaved,
      this.labelText,
      this.fieldicon,
      this.iconButton,
      this.initialValue,
      // this.intialValue,
      this.controller,
      this.textfiledColor,
      required this.obscureText,
      this.maxLines = 1,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              labelText!,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 71, 71, 71)),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          TextFormField(
            onSaved: onSaved,
            initialValue: initialValue,
            //was TextField
            maxLines: maxLines,
            obscureText: obscureText,
            controller: initialValue != null ? null : controller,

            decoration: InputDecoration(
              // labelText: intialValue,
              suffixIcon: iconButton,
              prefixIcon: fieldicon,
              hintText: hintText,
              hintStyle: TextStyle(color: Color(0XFF939199)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 17, horizontal: 10),
              filled: true,
              fillColor: textfiledColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0), //was 9.0
                borderSide: BorderSide(
                  color: Color(0XFFF5F6F8),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(25.0), //was 9.0
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
