part of 'add_post_bloc.dart';

sealed class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

final class AddPostInitial extends AddPostState {}

class AddPostLoaded extends AddPostState {
  final int post;
  const AddPostLoaded(this.post);
  @override
  List<Object> get props => [];
}

class AddPostError extends AddPostState {
  final String message;
  const AddPostError({required this.message});
  @override
  List<Object> get props => [message];
}

class AddPostLoading extends AddPostState {
  const AddPostLoading();
  @override
  List<Object> get props => [];
}
