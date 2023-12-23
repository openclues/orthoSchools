part of 'load_post_bloc.dart';

sealed class LoadPostState extends Equatable {
  const LoadPostState();
  
  @override
  List<Object> get props => [];
}

final class LoadPostInitial extends LoadPostState {}


class LoadPostLoaded extends LoadPostState {
  final LatestUpdatedPost post;
  const LoadPostLoaded({required this.post});
  @override
  List<Object> get props => [post];
}



class LoadPostError extends LoadPostState {
  final String message;
  const LoadPostError({required this.message});
  @override
  List<Object> get props => [message];
}


class LoadPostLoading extends LoadPostState {
  const LoadPostLoading();
  @override
  List<Object> get props => [];
}


class LoadPostCommentsLoaded extends LoadPostState {
  final PageModel<Comment> comments;
  const LoadPostCommentsLoaded({required this.comments});
  @override
  List<Object> get props => [comments];
}


class LoadPostCommentsError extends LoadPostState {
  final String message;
  const LoadPostCommentsError({required this.message});
  @override
  List<Object> get props => [message];
}


class LoadPostCommentsLoading extends LoadPostState {
  const LoadPostCommentsLoading();
  @override
  List<Object> get props => [];
}

