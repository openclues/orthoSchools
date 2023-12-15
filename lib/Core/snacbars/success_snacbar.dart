import 'package:flutter/material.dart';

class SnackBarWidget {
  static SnackBar success(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
  }

  static SnackBar faliure(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
  }
}
