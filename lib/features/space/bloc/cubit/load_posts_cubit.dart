import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../home_screen/data/models/latest_updated_posts_model.dart';
import '../../../home_screen/data/models/pagination_model.dart';
import 'repo/space_screen_repo.dart';

part 'load_posts_state.dart';

class LoadPostsCubit extends Cubit<LoadPostsState> {
  SpaceScreenRepo loadPostRepo = SpaceScreenRepo();
  LoadPostsCubit() : super(LoadPostsInitial());

  loadPosts(int id, {String? filter}) {
    emit(LoadSpacePostsLoading());
    loadPostRepo.getspacePosts(id.toString(), filter).then((value) {
      if (value.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(value.bodyBytes));
        PageModel<LatestUpdatedPost> pageModel =
            PageModel<LatestUpdatedPost>.fromJson(
                decodedResponse, (json) => LatestUpdatedPost.fromJson(json));
        emit(LoadSpacePostsLoaded(posts: pageModel));
      } else {
        emit(const LoadSpacePostsError(message: 'Something went wrong'));
      }
    });
  }
}
