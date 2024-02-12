part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeScreenData extends HomeScreenEvent {
  const LoadHomeScreenData();
  @override
  List<Object> get props => [];
}

class ReasetHomeScreenData extends HomeScreenEvent {
  const ReasetHomeScreenData();
  @override
  List<Object> get props => [];
}

class LoadMorePosts extends HomeScreenEvent {
  final String? nextUrl;
  final HomeScreenLoaded homeLoaded;

  const LoadMorePosts({required this.nextUrl, required this.homeLoaded});
  @override
  List<Object> get props => [];
}

class UpdatePostLocally extends HomeScreenEvent {
  final LatestUpdatedPost post;
  final HomeScreenLoaded homeLoaded;

  const UpdatePostLocally({required this.post, required this.homeLoaded});
  @override
  List<Object> get props => [
        post,
        homeLoaded,
      ];
}
