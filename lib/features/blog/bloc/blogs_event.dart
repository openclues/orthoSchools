part of 'blogs_bloc.dart';

sealed class BlogsEvent extends Equatable {
  const BlogsEvent();

  @override
  List<Object> get props => [];
}



class LoadBlogs extends BlogsEvent {
  const LoadBlogs();

  @override
  List<Object> get props => [];
}