import 'dart:convert';

import 'package:azsoon/features/space/bloc/cubit/repo/space_screen_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../comments/comment_model.dart';
import '../../../home_screen/data/models/latest_updated_posts_model.dart';

part 'space_post_comments_state.dart';

class SpacePostCommentsCubit extends Cubit<SpacePostCommentsState> {
  SpaceScreenRepo spaceScreenRepo = SpaceScreenRepo();
  SpacePostCommentsCubit() : super(SpacePostCommentsInitial());

  loadSpacePostComments(int? spaceId, {bool? loading}) async {
    if (loading != false) {
      emit(SpacePostCommentsLoading());
    }
    var response =
        await spaceScreenRepo.getSpacePostComments(spaceId.toString());
    if (response.statusCode == 200) {
      List<NewPostComment> comments = [];
      for (var item in jsonDecode(utf8.decode(response.bodyBytes))) {
        comments.add(NewPostComment.fromJson(item));
      }
      comments.sort((a, b) => b.id!.compareTo(a.id!));
      emit(SpacePostCommentsLoaded(comments: comments));
    } else {
      emit(SpacePostCommentsError());
    }
  }

  addSpacePostCommentLocally(
      SpacePostCommentsLoaded spacePostCommentsLoaded, NewPostComment comment) {
    List<NewPostComment> comments = spacePostCommentsLoaded.comments;
    comments.add(comment);
    comments.sort((a, b) => b.id!.compareTo(a.id!));
    emit(SpacePostCommentsLoaded(comments: comments));
  }

  addReplyLocally(
      {required SpacePostCommentsLoaded spacePostCommentsLoaded,
      required PostReply comment,
      required NewPostComment parentComment}) {
    List<NewPostComment> comments = spacePostCommentsLoaded.comments;

    // parentComment.comments!.add(comment);
    int index =
        comments.indexWhere((element) => element.id == parentComment.id);
    comments[index].replies!.add(comment);
    emit(SpacePostCommentsLoaded(comments: comments));
  }
  getComment(int id){
    return (state as SpacePostCommentsLoaded).comments.firstWhere((element) => element.id == id);
  }
  // addSpacePostCommentLocally(
  //     SpacePostCommentsLoaded spacePostCommentsLoaded, Comment comment) {
  //   List<Comment> comments = spacePostCommentsLoaded.comments;
  //   comments.add(comment);
  //   comments.sort((a, b) => b.id!.compareTo(a.id!));
  //   emit(SpacePostCommentsLoaded(comments: comments));
  // }

  // updateCommentLocally(
  //     SpacePostCommentsLoaded spacePostCommentsLoaded, Comment comment) {
  //   List<Comment> comments = spacePostCommentsLoaded.comments;
  //   int index = comments.indexWhere((element) => element.id == comment.id);
  //   comments[index] = comment;
  //   emit(SpacePostCommentsLoaded(comments: comments));
  // }

  // addReplyLocally(
  //     {required SpacePostCommentsLoaded spacePostCommentsLoaded,
  //     required Comment comment,
  //     required Comment parentComment}) {
  //   List<Comment> comments = spacePostCommentsLoaded.comments;
  //   // parentComment.comments!.add(comment);
  //   int index =
  //       comments.indexWhere((element) => element.id == parentComment.id);
  //   comments[index].comments!.add(comment);
  //   emit(SpacePostCommentsLoaded(comments: comments));
  // }
}
