part of 'blogs_bloc.dart';

sealed class BlogsEvent extends Equatable {
  const BlogsEvent();

  @override
  List<Object> get props => [];
}



class LoadBlogs extends BlogsEvent {
 final int? page;
  const LoadBlogs({this.page});

  @override
  List<Object> get props => [];
}