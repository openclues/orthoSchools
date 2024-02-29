import 'dart:convert';

import 'package:azsoon/features/blog/data/articles_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../comments/comment_model.dart';
import '../../data/models/article_comments_model.dart';

part 'blog_comments_state.dart';

class BlogCommentsCubit extends Cubit<BlogCommentsState> {
  ArticlesRepo articlesRepo = ArticlesRepo();
  BlogCommentsCubit() : super(BlogCommentsInitial());

  loadComments(int? postId) async {
    emit(const BlogCommentsLoading());
    var response = await articlesRepo.getArticleComments(postId.toString());
    if (response.statusCode == 200) {
      List<ArticleCommentModel> comments = [];
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      jsonDecode(utf8.decode(response.bodyBytes))['comments']
          .forEach((comment) {
        comments.add(ArticleCommentModel.fromJson(comment));
      });
      emit(BlogCommentsLoaded(
          blogComments: comments,
          isLiked: jsonDecode(response.body)['isLiked'],
          articleLikes: jsonDecode(response.body)['likes_count']));
    }
    // List<Comment> comments = [];
    // jsonDecode(utf8.decode(response.bodyBytes))['comments'].forEach((comment) {
    //   comments.add(Comment.fromJson(comment));
    // });
    // emit(const BlogCommentsLoaded(isLiked: true, blogComments: [], articleLikes: 0));
  }

  likeArticle(int? id, BlogCommentsLoaded state) async {
    var response = await articlesRepo.likeAndUnlikeArticle(id.toString());
    if (response.statusCode == 200) {
      emit(BlogCommentsLoaded(
          blogComments: state.blogComments,
          isLiked: jsonDecode(utf8.decode(response.bodyBytes))['isLiked'],
          articleLikes: jsonDecode(
              utf8.decode(response.bodyBytes))['parent_likes_count']));
    }
  }
}
