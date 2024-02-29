part of 'load_posts_cubit.dart';

sealed class LoadPostsState extends Equatable {
  const LoadPostsState();

  @override
  List<Object> get props => [];
}

final class LoadPostsInitial extends LoadPostsState {}

class LoadSpacePostsLoading extends LoadPostsState {}

class LoadSpacePostsLoaded extends LoadPostsState {
  final PageModel<LatestUpdatedPost> posts;

  const LoadSpacePostsLoaded({required this.posts});

  @override
  List<Object> get props => [posts];

  LoadSpacePostsLoaded copyWith({
    PageModel<LatestUpdatedPost>? posts,
  }) {
    return LoadSpacePostsLoaded(
      posts: posts ?? this.posts,
    );
  }
}

class LoadSpacePostsError extends LoadPostsState {
  final String message;

  const LoadSpacePostsError({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadMorePostsLoading extends LoadPostsState {}
