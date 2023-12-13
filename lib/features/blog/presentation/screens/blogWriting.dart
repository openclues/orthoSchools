import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:file_picker/file_picker.dart';

class BlogWritingScreen extends StatefulWidget {
  static const String routeName = '/blog';
  const BlogWritingScreen({Key? key}) : super(key: key);

  @override
  State<BlogWritingScreen> createState() => _BlogWritingScreenState();
}

class _BlogWritingScreenState extends State<BlogWritingScreen> {
  late QuillBaseToolbarConfigurations configurations;

  @override
  void initState() {
    super.initState();
    // Initialize configurations as needed
    configurations = QuillBaseToolbarConfigurations(
      childrenBuilder: (context) {
        return [
          IconButton(
            icon: Icon(Icons.format_bold),
            onPressed: () {
              // Handle bold text formatting
            },
          ),
          IconButton(
            icon: Icon(Icons.format_italic),
            onPressed: () {
              // Handle italic text formatting
            },
          ),
          // Add more buttons as needed
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
