part of 'blogs_bloc.dart';

sealed class BlogsState extends Equatable {
  const BlogsState();

  @override
  List<Object> get props => [];
}

final class BlogsInitial extends BlogsState {}

final class BlogsLoading extends BlogsState {}

final class BlogsLoaded extends BlogsState {
  final List<Blog> blogs;

  const BlogsLoaded(this.blogs);

  @override
  List<Object> get props => [blogs];
}

class Blog {}
