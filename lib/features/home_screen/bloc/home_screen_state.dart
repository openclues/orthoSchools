part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final List<RecommendedSpace> recommendedSpaces;
  final bool isLoading;
  final PageModel<LatestUpdatedPost> posts;

  const HomeScreenLoaded(
      {required this.recommendedSpaces, required this.posts, this.isLoading = false});

  @override
  List<Object> get props => [recommendedSpaces, posts, isLoading];

  HomeScreenLoaded copyWith({
    bool? isLoading,
    List<RecommendedSpace>? recommendedSpaces,
    PageModel<LatestUpdatedPost>? posts,
  }) {
    return HomeScreenLoaded(
      isLoading: isLoading ?? this.isLoading,
      recommendedSpaces: recommendedSpaces ?? this.recommendedSpaces,
      posts: posts ?? this.posts,
    );
  }
}

class HomeScreenError extends HomeScreenState {
  final String message;
  const HomeScreenError({required this.message});
}

class HomeScreenNotAuthenticated extends HomeScreenState {
  final String message;
  const HomeScreenNotAuthenticated({required this.message});
}
