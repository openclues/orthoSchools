import 'home_screen_model.dart';

class RecommendedSpace {
  final int? id;
  final String? name;
  final String? description;
  final String? type;
  final String? cover;
  final bool? isAllowedToJoin;
  final int? membersCount;
  bool? isJoined;
  final List<Category>? category;

  RecommendedSpace({
    required this.id,
    required this.name,
    required this.description,
    required this.cover,
    required this.isAllowedToJoin,
    required this.membersCount,
    required this.type,
    required this.isJoined,
    required this.category,
  });

  factory RecommendedSpace.fromJson(Map<String, dynamic> json) {
    // Parse the 'category' list from the JSON and convert it to a list of Category objects
    List<Category>? categoryList = (json['category'] as List?)
        ?.map((categoryJson) => Category.fromJson(categoryJson))
        .toList();

    return RecommendedSpace(
      id: json['id'],
      isJoined: json['joined'],
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
