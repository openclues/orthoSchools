part of 'articles_feed_bloc.dart';

sealed class ArticlesFeedEvent extends Equatable {
  const ArticlesFeedEvent();

  @override
  List<Object> get props => [];
}

class FetchArticlesFeed extends ArticlesFeedEvent {
  const FetchArticlesFeed();
  @override
  List<Object> get props => [];
}

class LoadMoreArticles extends ArticlesFeedEvent {
  final String? nextUrl;
  final ArticlesFeedLoaded articlesFeedLoaded;

  const LoadMoreArticles(
      {required this.nextUrl, required this.articlesFeedLoaded});
  @override
  List<Object> get props => [];
}
