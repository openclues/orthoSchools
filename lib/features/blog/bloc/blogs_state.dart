part of 'blogs_bloc.dart';

sealed class BlogsState extends Equatable {
  const BlogsState();

  @override
  List<Object> get props => [];
}

final class BlogsInitial extends BlogsState {}

final class BlogsLoading extends BlogsState {}
final class BlogsFiltering extends BlogsState {}

final class BlogsLoaded extends BlogsState {
  final PaginationBlogListModel blogs;

  const BlogsLoaded(this.blogs);

  @override
  List<Object> get props => [blogs];
}



final class BlogErr extends BlogsState {
  final String message;

  const BlogErr({required this.message});

  @override
  List<Object> get props => [message];
}