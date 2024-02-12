part of 'blogs_bloc.dart';

sealed class BlogsEvent extends Equatable {
  const BlogsEvent();

  @override
  List<Object> get props => [];
}

class LoadBlogs extends BlogsEvent {
  final int? page;
  final String? category;
  final bool? following;
  const LoadBlogs({
    this.page,
    this.category,
    this.following,
  });

  @override
  List<Object> get props => [];
}


