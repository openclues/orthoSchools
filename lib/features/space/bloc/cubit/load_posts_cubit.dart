import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/network/request_helper.dart';
import '../../../home_screen/bloc/home_screen_bloc.dart';
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

  loadMorePosts(LoadSpacePostsLoaded state) {
    // if (state.posts.next != null) {
    // emit(LoadMorePostsLoading());
    loadPostRepo.getMorePosts(state.posts.next!).then((value) {
      if (value.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(value.bodyBytes));
        PageModel<LatestUpdatedPost> pageModel =
            PageModel<LatestUpdatedPost>.fromJson(
                decodedResponse, (json) => LatestUpdatedPost.fromJson(json));
        // state.posts.results.addAll(pageModel.results);

        emit(state.copyWith(
            posts: state.posts.copyWith(
          results: state.posts.results + pageModel.results,
          next: pageModel.next,
        )));
      } else {
        emit(const LoadSpacePostsError(message: 'Something went wrong'));
      }
    });
    // }
  }

  getUpdatedPost(BuildContext context, int postId) async {
    var response = await RequestHelper.get('post/${postId.toString()}');
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      LatestUpdatedPost post = LatestUpdatedPost.fromJson(decodedResponse);
      if (context.mounted &&
          context.read<HomeScreenBloc>().state is HomeScreenLoaded) {
        context.read<HomeScreenBloc>().add(UpdatePostLocally(
            post: post,
            homeLoaded:
                context.read<HomeScreenBloc>().state as HomeScreenLoaded));
      }
      return post;
    }
  }
}
