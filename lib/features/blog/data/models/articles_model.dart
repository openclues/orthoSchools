import 'dart:convert';

import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:flutter_quill/quill_delta.dart';

class ArticlesModel {
  int? id;
  // Delta? content;
  String? plainText;
  String? title;
  bool? isBanned;
  String? cover;
  DateTime? createdAt;
  bool? isFollowed;
  DateTime? updatedAt;
  BlogsModel? blog;
  bool? isLiked;
  int? likesCount;
  int? commentsCount;

  // bool? isFollowed;
  ArticlesModel({
    this.commentsCount,
    this.likesCount,
    this.id,
    // this.content,
    this.title,
    this.isBanned,
    this.cover,
    this.createdAt,
    this.isFollowed,
    this.plainText,
    this.updatedAt,
    this.blog,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
    return ArticlesModel(
        id: json['id'],
        // content: json['content'] != null
        //     ? Delta.fromJson(jsonDecode(json['content'])['ops'])
        // : null,
        title: json['title'],
        isBanned: json['is_banned'],
        cover: json['cover'],
        createdAt: DateTime.parse(json['created_at']),
        isFollowed: json['is_followed'],
        updatedAt: DateTime.parse(json['updated_at']),
        blog: BlogsModel.fromJson(json['blog']),
        plainText: json['content']);
  }
}

class BlogsModel {
  int? id;
  String? title;
  String? description;
  String? cover;
  String? color;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;
  List<CategoryModel> categories;

  BlogsModel({
    this.color,
    this.id,
    this.title,
    this.description,
    this.cover,
    this.createdAt,
    this.updatedAt,
    required this.categories,
    this.user,
  });

  factory BlogsModel.fromJson(Map<String, dynamic> json) {
    return BlogsModel(
      id: json['id'],
      // color: json['color'] ?? primaryColor,
      categories: json['categories'] != null
          ? (json['categories'] as List<dynamic>)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
          : [],
      title: json['title'],
      description: json['description'],
      cover: json['cover'].toString().contains('http')
          ? json['cover']
          : ApiEndpoints.baseUrl + json['cover'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: UserModel.fromJson(json['user']),
    );
  }
}
