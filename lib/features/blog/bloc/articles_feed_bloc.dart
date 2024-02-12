import 'dart:convert';

import 'package:azsoon/features/blog/data/articles_repo.dart';
import 'package:azsoon/features/home_screen/data/models/pagination_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/articles_model.dart';
import '../data/models/blog_model.dart';

part 'articles_feed_event.dart';
part 'articles_feed_state.dart';

class ArticlesFeedBloc extends Bloc<ArticlesFeedEvent, ArticlesFeedState> {
  ArticlesRepo articlesRepo = ArticlesRepo();
  ArticlesFeedBloc() : super(ArticlesFeedInitial()) {
    on<FetchArticlesFeed>((event, emit) async {
      emit(const ArticlesFeedLoading());
      List<BlogModel> recommendedBlogs = [];
      List<ArticlesModel> recommendedArticles = [];
      try {
        var recommendedBlogsresponse = await articlesRepo.getRecommendedBlogs();
        if (recommendedBlogsresponse.statusCode == 200) {
          for (var blog
              in jsonDecode(utf8.decode(recommendedBlogsresponse.bodyBytes))) {
            recommendedBlogs.add(BlogModel.fromJson(blog));
          }
        }

        var recommendedArticlesresponse = await articlesRepo.getArticles();
        if (recommendedArticlesresponse.statusCode == 200) {
          PageModel<ArticlesModel> pageModel = PageModel.fromJson(
              jsonDecode(utf8.decode(recommendedArticlesresponse.bodyBytes)),
              (json) => ArticlesModel.fromJson(json));
          recommendedArticles = pageModel.results;

          print(pageModel.results.toList().toString());
        }
        emit(ArticlesFeedLoaded(
            recommendedBlogs: recommendedBlogs,
            recommendedArticles: recommendedArticles,
            isLoading: false));
      } catch (e) {
        emit(ArticlesFeedError(message: e.toString()));
      }
    });
  }
}
