part of 'articles_feed_bloc.dart';

sealed class ArticlesFeedState extends Equatable {
  const ArticlesFeedState();

  @override
  List<Object> get props => [];
}

final class ArticlesFeedInitial extends ArticlesFeedState {}

class ArticlesFeedLoading extends ArticlesFeedState {
  const ArticlesFeedLoading();
  @override
  List<Object> get props => [];
}

class ArticlesFeedLoaded extends ArticlesFeedState {
  final List<BlogModel> recommendedBlogs;
  final List<ArticlesModel> recommendedArticles;
  final bool isLoading;

  const ArticlesFeedLoaded(
      {required this.recommendedBlogs,
      required this.isLoading,
      required this.recommendedArticles});
  @override
  List<Object> get props => [
        recommendedBlogs,
        isLoading,
      ];

  ArticlesFeedLoaded copyWith({
    List<BlogModel>? recommendedBlogs,
    bool? isLoading,
    List<ArticlesModel>? recommendedArticles,
  }) {
    return ArticlesFeedLoaded(
      recommendedArticles: recommendedArticles ?? this.recommendedArticles,
      recommendedBlogs: recommendedBlogs ?? this.recommendedBlogs,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}


class ArticlesFeedError extends ArticlesFeedState {
  final String message;
  const ArticlesFeedError({required this.message});
  @override
  List<Object> get props => [message];
}