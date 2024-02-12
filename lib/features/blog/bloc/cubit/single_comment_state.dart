part of 'single_comment_cubit.dart';

sealed class SingleCommentState extends Equatable {
  const SingleCommentState();

  @override
  List<Object> get props => [];
}

final class SingleCommentInitial extends SingleCommentState {}


class SingleCommentLoading extends SingleCommentState {
  const SingleCommentLoading();
  @override
  List<Object> get props => [];
}


class SingleCommentLoaded extends SingleCommentState {
  final NewPostComment comment;
  const SingleCommentLoaded({required this.comment});
  @override
  List<Object> get props => [comment];

  SingleCommentLoaded copyWith({
    NewPostComment? comment,
  }) {
    return SingleCommentLoaded(
      comment: comment ?? this.comment,
    );
  }
}


