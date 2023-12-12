import 'package:azsoon/features/home_screen/data/models/home_screen_model.dart';
import 'package:azsoon/features/profile/data/user_profile_model.dart';

import '../../home_screen/data/models/latest_updated_posts_model.dart';

class Space {
  int? id;
  String? name;
  String? description;
  String? cover;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? allowedUserTypes;
  List<Category>? category;
  List<int>? excludeUsers;
  List<int>? includeUsers;
  List<LatestUpdatedPost>? posts;

  Space({
    this.id,
    this.name,
    this.description,
    this.cover,
    this.createdAt,
    this.updatedAt,
    this.allowedUserTypes,
    this.category,
    this.excludeUsers,
    this.includeUsers,
    this.posts,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    print(json['category']);
    return Space(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      cover: json['cover'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      allowedUserTypes: json['allowed_user_types'],
      category: json['category'] != null
          ? List<Category>.from(
              json['category'].map((x) => Category.fromJson(x)))
          : [],
      excludeUsers: (json['exclude_users'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      includeUsers: (json['include_users'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      posts: json['posts'] != null
          ? List<LatestUpdatedPost>.from(
              json['posts'].map((x) => LatestUpdatedPost.fromJson(x)))
          : [],
    );
  }
}

class SpacePost {
  //  {"id":17,"content":"nnnnnhhhhvv","space":1,"user":{"id":4,"first_name":"islam","last_name":"string","profileImage":null},"comments":[],"post_files":[],"post_images":[],"created_at":"2023-12-11T08:23:32.489759Z","is_joined":true,"updated_at":"2023-12-11T08:23:32.489759Z","space_name":"Basic space","is_allowed_to_join":true}
  int? id;
  String? content;
  int? space;
  UserModel? user;
  List<dynamic>? comments;
  List<dynamic>? postFiles;
  List<String>? postImages;
  DateTime? createdAt;
  bool? isJoined;
  DateTime? updatedAt;
  String? spaceName;
  bool? isAllowedToJoin;

  SpacePost({
    this.id,
    this.content,
    this.space,
    this.user,
    this.comments,
    this.postFiles,
    this.postImages,
    this.createdAt,
    this.isJoined,
    this.updatedAt,
    this.spaceName,
    this.isAllowedToJoin,
  });

  factory SpacePost.fromJson(Map<String, dynamic> json) {
    return SpacePost(
      id: json['id'],
      content: json['content'],
      space: json['space'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      comments: json['comments'],
      postFiles: json['post_files'],
      postImages: json['post_images'] != null
          ? List<String>.from(json['post_images'])
          : [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      isJoined: json['is_joined'],
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      spaceName: json['space_name'],
      isAllowedToJoin: json['is_allowed_to_join'],
    );
  }

}


