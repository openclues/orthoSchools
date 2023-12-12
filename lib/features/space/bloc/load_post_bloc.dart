import 'dart:convert';

import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/space/data/space_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/space_repo.dart';

part 'load_post_event.dart';
part 'load_post_state.dart';

class LoadPostBloc extends Bloc<LoadPostEvent, LoadPostState> {
  LoadPostBloc() : super(LoadPostInitial()) {
    SpaceRepo spaceRepo = SpaceRepo();
    on<LoadPostEvent>((event, emit) {
    });
    on<LoadPost>((event, emit) async {
      emit(const LoadPostLoading());
      var response = await spaceRepo.getPost(event.postId);
      if (response.statusCode == 200) {
        var post = LatestUpdatedPost.fromJson(jsonDecode(response.body));
        emit(LoadPostLoaded(post: post));
      } else {
        emit(const LoadPostError(message: ""));
      }
    });
  }
}
