part of 'blog_cupit_cubit.dart';

sealed class BlogCupitState extends Equatable {
  const BlogCupitState();

  @override
  List<Object> get props => [];
}

final class BlogCupitInitial extends BlogCupitState {}

class BlogCupitLoading extends BlogCupitState {
  const BlogCupitLoading();
  @override
  List<Object> get props => [];
}

class BlogCupitLoaded extends BlogCupitState {
  final BlogScreenModel blogScreen;
  final bool filtering;
  const BlogCupitLoaded({required this.blogScreen, required this.filtering});
  @override
  List<Object> get props => [
        blogScreen,
        filtering,
        blogScreen.blog,
        blogScreen.blogPosts,
        blogScreen.categories,
        blogScreen.latestUpdatedPosts,
        blogScreen.isFollowed
      ];

  BlogCupitLoaded copyWith({
    BlogScreenModel? blogScreen,
    bool? filtering,
  }) {
    return BlogCupitLoaded(
      blogScreen: blogScreen ?? this.blogScreen,
      filtering: filtering ?? this.filtering,
    );
  }
}

class BlogScreenModel extends Equatable {
  final BlogsModel blog;
  final bool isFollowed;
  final List<ArticlesModel> blogPosts;
  final List<CategoryModel> categories;
  final List<ArticlesModel> latestUpdatedPosts;

  const BlogScreenModel({
    required this.blog,
    required this.isFollowed,
    required this.blogPosts,
    required this.latestUpdatedPosts,
    required this.categories,
  });

  BlogScreenModel copyWith({
    BlogsModel? blog,
    List<CategoryModel>? categories,
    bool? isFollowed,
    List<ArticlesModel>? blogPosts,
  }) {
    print('copyWith called $isFollowed isFollowed');
    return BlogScreenModel(
      categories: categories ?? this.categories,
      blog: blog ?? this.blog,
      isFollowed: isFollowed ?? this.isFollowed,
      blogPosts: blogPosts ?? this.blogPosts,
      latestUpdatedPosts: latestUpdatedPosts ?? this.latestUpdatedPosts,
    );
  }

  //from json
  factory BlogScreenModel.fromJson(Map<String, dynamic> json) {
    return BlogScreenModel(
      categories: List<CategoryModel>.from(
          json['categories'].map((x) => CategoryModel.fromJson(x))),
      blog: BlogsModel.fromJson(json['blog']),
      isFollowed: json['is_followed'],
      latestUpdatedPosts:
          List<ArticlesModel>.from(json['posts'].map((x) => ArticlesModel.fromJson(x))),
      blogPosts: List<ArticlesModel>.from(
          json['featured_posts'].map((x) => ArticlesModel.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [blog, categories, isFollowed, blogPosts];
}
