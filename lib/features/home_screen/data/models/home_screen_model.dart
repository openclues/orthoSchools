

import 'package:azsoon/features/home_screen/data/models/recommended_spaces_model.dart';

import 'latest_updated_posts_model.dart';

class HomeScreenModel {
  final List<RecommendedSpace>? recommendedSpaces;
  final List<LatestUpdatedPost>? latestUpdatedPostsFromRecommended;
  final List<LatestUpdatedPost>? myLatestUpdatedPosts;

  HomeScreenModel({
    required this.recommendedSpaces,
    required this.latestUpdatedPostsFromRecommended,
    required this.myLatestUpdatedPosts,
  });

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) {
    // Parse the 'recommendedSpaces' list from the JSON and convert it to a list of RecommendedSpace objects
    List<RecommendedSpace>? recommendedSpacesList = (json['recommended_spaces'] as List?)
        ?.map((recommendedSpaceJson) => RecommendedSpace.fromJson(recommendedSpaceJson))
        .toList();

    // Parse the 'latest_updated_posts_from_recommended' list from the JSON and convert it to a list of LatestUpdatedPost objects
    List<LatestUpdatedPost>? latestUpdatedPostsFromRecommendedList = (json['latest_updated_posts_from_recommended'] as List?)
        ?.map((latestUpdatedPostJson) => LatestUpdatedPost.fromJson(latestUpdatedPostJson))
        .toList();

    // Parse the 'my_latest_updated_posts' list from the JSON and convert it to a list of LatestUpdatedPost objects
    List<LatestUpdatedPost>? myLatestUpdatedPostsList = (json['my_latest_updated_posts'] as List?)
        ?.map((myLatestUpdatedPostJson) => LatestUpdatedPost.fromJson(myLatestUpdatedPostJson))
        .toList();

    return HomeScreenModel(
      recommendedSpaces: recommendedSpacesList,
      latestUpdatedPostsFromRecommended: latestUpdatedPostsFromRecommendedList,
      myLatestUpdatedPosts: myLatestUpdatedPostsList,
    );
  }
}

class Category {
  final int? id;
  final bool? isSelected;
  final String? name;
  final String? image;

  Category({
    required this.id,
    required this.isSelected,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      isSelected: json['is_selected'],
      name: json['name'],
      image: json['image'],
    );
  }
}
