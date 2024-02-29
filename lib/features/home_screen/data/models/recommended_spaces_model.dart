import 'package:equatable/equatable.dart';

import 'home_screen_model.dart';
import 'member_model.dart';

class RecommendedSpace extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? type;
  final String? cover;
  final int? postsCount;
  final bool? isAllowedToJoin;
  final int? membersCount;
  final bool? isJoined;
  final List<MemberModel>? members;
  final List<Category>? category;

  RecommendedSpace({
    required this.id,
    required this.name,
    required this.description,
    this.members,
    required this.cover,
    required this.postsCount,
    required this.isAllowedToJoin,
    required this.membersCount,
    required this.type,
    required this.isJoined,
    required this.category,
  });

  factory RecommendedSpace.fromJson(Map<String, dynamic> json) {
    print(json['users']);
    // Parse the 'category' list from the JSON and convert it to a list of Category objects
    List<Category>? categoryList = (json['category'] as List?)
        ?.map((categoryJson) => Category.fromJson(categoryJson))
        .toList();
    return RecommendedSpace(
      postsCount: json['posts_count'],
      id: json['id'],
      isJoined: json['joined'],
      members: (json['users'] as List?)
          ?.map((memberJson) => MemberModel.fromJson(memberJson))
          .toList(),
      type: json['allowed_user_types'],
      name: json['name'],
      description: json['description'],
      cover: json['cover'],
      isAllowedToJoin: json['is_allowed_to_join'],
      membersCount: json['members_count'],
      category: categoryList,
    );
  }
  //copy with method
  RecommendedSpace copyWith({
    int? id,
    String? name,
    String? description,
    String? type,
    String? cover,
    int? postsCount,
    bool? isAllowedToJoin,
    int? membersCount,
    bool? isJoined,
    List<MemberModel>? members,
    List<Category>? category,
  }) {
    return RecommendedSpace(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      cover: cover ?? this.cover,
      postsCount: postsCount ?? this.postsCount,
      isAllowedToJoin: isAllowedToJoin ?? this.isAllowedToJoin,
      membersCount: membersCount ?? this.membersCount,
      isJoined: isJoined ?? this.isJoined,
      members: members ?? this.members,
      category: category ?? this.category,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        description,
        type,
        cover,
        postsCount,
        isAllowedToJoin,
        membersCount,
        isJoined,
        members,
        category
      ];
}
