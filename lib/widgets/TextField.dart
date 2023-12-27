import 'package:flutter/material.dart';
import 'package:azsoon/Utils/Constants.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Icon? fieldicon;
  void Function(String?)? onSaved;
  void Function()? onTap;
  final IconButton? iconButton;
  final Color? textfiledColor;
  final TextEditingController? controller;
  final Color borderColor;
  final bool obscureText;
  final String? Function(String?)? validator;
  String? initialValue;

  final int? maxLines;
  final bool? readOnly;
  // final String? intialValue;

  CustomTextField(
      {super.key,
      this.hintText,
      this.readOnly,
      this.onTap,
      this.validator,
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
    // controller!.text = initialValue ?? '';
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          TextFormField(
            validator: validator,
            readOnly: readOnly ?? false,
            onTap: onTap,
            onSaved: onSaved,
            initialValue: initialValue,
            //was TextField
            maxLines: maxLines,
            controller: controller,
            obscureText: obscureText,

            decoration: InputDecoration(
              // labelText: intialValue,
              suffixIcon: iconButton,
              prefixIcon: fieldicon,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 194, 193, 199),
                fontSize: 14.0,
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15), //symmetric(vertical: 17, horizontal: 10),
              filled: true,
              fillColor: textfiledColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), //was 9.0
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(15.0), //was 9.0
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewCustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Icon? fieldicon;
  void Function(String?)? onSaved;
  final IconButton? iconButton;
  final Color? textfiledColor;
  final Color borderColor;
  final bool obscureText;
  String? initialValue;

  final int? maxLines;
  // final String? intialValue;

  NewCustomTextField(
      {super.key,
      this.hintText,
      this.onSaved,
      this.labelText,
      this.fieldicon,
      this.iconButton,
      this.initialValue,
      // this.intialValue,

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
              labelText ?? '',
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 171, 171, 171)),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormField(
            onSaved: onSaved,
            initialValue: initialValue,
            // initialValue: initialValue,
            //was TextField
            maxLines: maxLines,
            obscureText: obscureText,
            // controller: initialValue != null || initialValue!.isNotEmpty
            //     ? null
            //     : controller,

            decoration: InputDecoration(
              // labelText: intialValue,
              suffixIcon: iconButton,
              prefixIcon: fieldicon,
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0XFF939199)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
              filled: true,
              fillColor: textfiledColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), //was 9.0
                borderSide: const BorderSide(
                  color: Color(0XFFF5F6F8),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(10.0), //was 9.0
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
