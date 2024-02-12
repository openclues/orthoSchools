import 'dart:convert';

import 'package:azsoon/features/blog/data/articles_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../comments/comment_model.dart';

part 'blog_comments_state.dart';

class BlogCommentsCubit extends Cubit<BlogCommentsState> {
  ArticlesRepo articlesRepo = ArticlesRepo();
  BlogCommentsCubit() : super(BlogCommentsInitial());

  loadComments(int? postId) async {
    emit(const BlogCommentsLoading());
    var response = await articlesRepo.getArticleComments(postId.toString());

    List<Comment> comments = [];
    jsonDecode(utf8.decode(response.bodyBytes))['comments'].forEach((comment) {
      comments.add(Comment.fromJson(comment));
    });
    emit(BlogCommentsLoaded(
        isLiked: jsonDecode(utf8.decode(response.bodyBytes))['isLiked'],
        blogComments: comments,
        articleLikes: jsonDecode(response.body)['parent_likes_count']));
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
