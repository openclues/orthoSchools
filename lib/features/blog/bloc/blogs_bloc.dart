import 'dart:convert';

import 'package:azsoon/features/blog/data/blog_repo.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'blogs_event.dart';
part 'blogs_state.dart';

class BlogsBloc extends Bloc<BlogsEvent, BlogsState> {
  String? category;
  bool? following;

  BlogRepo blogRepo = BlogRepo();
  BlogsBloc() : super(BlogsInitial()) {
    on<BlogsEvent>((event, emit) {});
    on<LoadBlogs>((event, emit) async {
      if (event.category != null || event.following != null) {
        emit(BlogsFiltering());
      } else {
        emit(BlogsLoading());
      }
      var response = await blogRepo.getBlogList(event.page,
          category: event.category, following: event.following);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        var blogs = PaginationBlogListModel.fromJson(data);
        // blogs.latest_updated_posts_model = blogs.results!.fold([],
        //     (previousValue, element) => previousValue!..addAll(element.posts));
        emit(BlogsLoaded(blogs));
      } else {
        emit(const BlogErr(message: 'Error loading blogs'));
      }
    });
  }
}
