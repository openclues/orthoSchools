part of 'blog_comments_cubit.dart';

sealed class BlogCommentsState extends Equatable {
  const BlogCommentsState();

  @override
  List<Object> get props => [];
}

final class BlogCommentsInitial extends BlogCommentsState {}

class BlogCommentsLoading extends BlogCommentsState {
  const BlogCommentsLoading();
  @override
  List<Object> get props => [];
}

class BlogCommentsLoaded extends BlogCommentsState {
  final List<Comment> blogComments;
  final bool isLiked;
  final int articleLikes;
  const BlogCommentsLoaded(
      {required this.blogComments,
      required this.articleLikes,
      required this.isLiked});
  @override
  List<Object> get props => [blogComments, articleLikes, isLiked];
}

class BlogCommentsError extends BlogCommentsState {
  final String message;
  const BlogCommentsError({required this.message});
  @override
  List<Object> get props => [message];
}
