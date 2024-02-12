import 'home_screen_model.dart';
import 'member_model.dart';

class RecommendedSpace {
  final int? id;
  final String? name;
  final String? description;
  final String? type;
  final String? cover;
  final int? postsCount;
  final bool? isAllowedToJoin;
  final int? membersCount;
  bool? isJoined;
  List<MemberModel>? members;
  List<Category>? category;

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
}
