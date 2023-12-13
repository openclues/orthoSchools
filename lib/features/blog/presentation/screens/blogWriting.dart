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
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
