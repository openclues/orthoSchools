part of 'load_post_bloc.dart';

sealed class LoadPostEvent extends Equatable {
  const LoadPostEvent();

  @override
  List<Object> get props => [];
}


class LoadPost extends LoadPostEvent {
  final String postId;
  const LoadPost({required this.postId});
  @override
  List<Object> get props => [postId];
}



class LoadPostComments extends LoadPostEvent {
  final String postId;
  const LoadPostComments({required this.postId});
  @override
  List<Object> get props => [postId];
}