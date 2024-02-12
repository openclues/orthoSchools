import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/models/latest_updated_posts_model.dart';
import '../data/models/pagination_model.dart';
import '../data/models/recommended_spaces_model.dart';
import '../data/respos/home_screen_repo.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    HomeScreenRepo homeScreenRepo = HomeScreenRepo();
    on<ReasetHomeScreenData>((event, emit) {
      emit(HomeScreenInitial());
    });
    on<LoadHomeScreenData>((event, emit) async {
      try {
        var response = await homeScreenRepo.getHomeScreenData();
        if (response.statusCode == 200) {
          var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
          List<RecommendedSpace> recommendedSpaces = [];

          for (var space in decodedResponse) {
            recommendedSpaces.add(RecommendedSpace.fromJson(space));
          }

          var postsResponse = await homeScreenRepo.getHomeScreenPosts();

          if (postsResponse.statusCode == 200) {
            var decodedResponse =
                jsonDecode(utf8.decode(postsResponse.bodyBytes));
            PageModel<LatestUpdatedPost> pageModel =
                PageModel<LatestUpdatedPost>.fromJson(decodedResponse,
                    (json) => LatestUpdatedPost.fromJson(json));

            emit(HomeScreenLoaded(
                recommendedSpaces: recommendedSpaces, posts: pageModel));
          }

          // var homeScreenModel = HomeScreenModel.fromJson(decodedResponse);
          // emit(HomeScreenLoaded(homeScreenModel: homeScreenModel));
        } else if (response.statusCode == 401) {
          emit(const HomeScreenNotAuthenticated(
              message: 'Your session has expired'));
        } else if (response.statusCode == 403 || response.statusCode == 401) {
          emit(const HomeScreenNotAuthenticated(
              message: 'Your session has expired'));
        } else {
          emit(const HomeScreenError(message: 'Something went wrong'));
        }
      } catch (e) {
        emit(const HomeScreenError(message: 'Something went wrong'));
      }
    });
    on<LoadMorePosts>((event, emit) async {
      emit(event.homeLoaded.copyWith(isLoading: true));

      var response = await homeScreenRepo.getMorePosts(event.nextUrl!);

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        PageModel<LatestUpdatedPost> pageModel =
            PageModel<LatestUpdatedPost>.fromJson(
                decodedResponse, (json) => LatestUpdatedPost.fromJson(json));

        emit(event.homeLoaded.copyWith(
            isLoading: false,
            posts: pageModel.copyWith(
                results: event.homeLoaded.posts.results + pageModel.results,
                next: pageModel.next,
                count: pageModel.count,
                previous: pageModel.previous)));
      } else if (response.statusCode == 401) {
        emit(const HomeScreenNotAuthenticated(
            message: 'Your session has expired'));
      } else if (response.statusCode == 403 || response.statusCode == 401) {
        emit(const HomeScreenNotAuthenticated(
            message: 'Your session has expired'));
      } else {
        emit(const HomeScreenError(message: 'Something went wrong'));
      }
    });
    on<UpdatePostLocally>((event, emit) {
      List<LatestUpdatedPost> posts = event.homeLoaded.posts.results;

      if (posts.any((element) => element.id == event.post.id)) {
        var index = posts.indexWhere((element) => element.id == event.post.id);
        posts[index] = event.post;
      }
      // posts[index] =
      //     event.post.copyWith(commentsCount: event.post.commentsCount);
      print("new comment was added");
      emit(event.homeLoaded
          .copyWith(posts: event.homeLoaded.posts.copyWith(results: posts)));
    });
  }
}
