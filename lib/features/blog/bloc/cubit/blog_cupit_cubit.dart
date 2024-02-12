import 'dart:convert';

import 'package:azsoon/features/blog/data/blog_repo.dart';
import 'package:azsoon/features/blog/data/models/blog_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/articles_model.dart';

part 'blog_cupit_state.dart';

class BlogCupitCubit extends Cubit<BlogCupitState> {
  BlogRepo blogRepo = BlogRepo();
  BlogCupitCubit() : super(BlogCupitInitial());

  updateBlogLocally(
    // int blogId,
    bool isFollowed,
  ) {
    BlogCupitLoaded blogScreenModel = (state as BlogCupitLoaded);
    blogScreenModel.blogScreen.copyWith(isFollowed: isFollowed);
    blogScreenModel.copyWith(blogScreen: blogScreenModel.blogScreen);

    emit(blogScreenModel);
  }

  loadBlogScreen(int blogId, String? filter, {bool? withoutloading}) async {
    if (withoutloading == null) {
      emit(const BlogCupitLoading());
    }
    if (state is BlogCupitLoaded) {
      print('state is BlogCupitLoaded');
      // var blogScreenModel = (state as BlogCupitLoaded).blogScreen;
      // blogScreenModel.copyWith(isFollowed: false);
      emit((state as BlogCupitLoaded).copyWith(filtering: true));
    }
    var response = await blogRepo.getBlogScreen(blogId, filter);
    if (response.statusCode == 200) {
      BlogScreenModel blogScreenModel =
          BlogScreenModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      emit(BlogCupitLoaded(blogScreen: blogScreenModel, filtering: false));
    } else {}
  }

  followunfollowLocally(
    bool isFollowed,
  ) {
    emit(state);
    // print(isFollowed.toString() + 'provided from event 123');
    BlogCupitLoaded blogScreenModel = (state as BlogCupitLoaded);
    blogScreenModel.blogScreen.copyWith(isFollowed: isFollowed);
    // blogScreenModel.copyWith(blogScreen: blogScreenModel.blogScreen);
    // print(blogScreenModel.blogScreen.isFollowed.toString() + 'result 123');
    emit(blogScreenModel.copyWith(
        blogScreen:
            blogScreenModel.blogScreen.copyWith(isFollowed: isFollowed)));
  }
}
