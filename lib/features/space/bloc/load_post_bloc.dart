import 'dart:convert';

import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/home_screen/data/models/pagination_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../comments/comment_model.dart';
import '../data/space_repo.dart';

part 'load_post_event.dart';
part 'load_post_state.dart';

class LoadPostBloc extends Bloc<LoadPostEvent, LoadPostState> {
  LoadPostBloc() : super(LoadPostInitial()) {
    SpaceRepo spaceRepo = SpaceRepo();
    on<LoadPostEvent>((event, emit) {});
    
    on<LoadPost>((event, emit) async {
      emit(const LoadPostLoading());
      var response = await spaceRepo.getPost(event.postId);
      if (response.statusCode == 200) {
        var post = LatestUpdatedPost.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
        emit(LoadPostLoaded(post: post));
      } else {
        emit(const LoadPostError(message: ""));
      }
    });

    on<LoadPostComments>((event, emit) => lostPostComments(event, emit));
  }

  lostPostComments(LoadPostComments event, Emitter<LoadPostState> emit) async {
    emit(const LoadPostCommentsLoading());
    var response = await SpaceRepo().getPostComments(event.postId);
    if (response.statusCode == 200) {
      PageModel<Comment> comments = PageModel<Comment>.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
          (json) => Comment.fromJson(json));
      emit(LoadPostCommentsLoaded(comments: comments));
    } else {
      emit(const LoadPostCommentsError(message: ""));
    }
  }
}
