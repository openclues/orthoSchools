part of 'space_post_comments_cubit.dart';

sealed class SpacePostCommentsState extends Equatable {
  const SpacePostCommentsState();

  @override
  List<Object> get props => [];
}

final class SpacePostCommentsInitial extends SpacePostCommentsState {}

final class SpacePostCommentsLoading extends SpacePostCommentsState {}

final class SpacePostCommentsLoaded extends SpacePostCommentsState {
  final List<NewPostComment> comments;

  const SpacePostCommentsLoaded({required this.comments});

  @override
  List<Object> get props => [comments];
}

class SpacePostCommentsError extends SpacePostCommentsState {
  @override
  List<Object> get props => [];
}
