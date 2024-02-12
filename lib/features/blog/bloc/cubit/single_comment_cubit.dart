import 'dart:convert';

import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../space/bloc/cubit/repo/space_screen_repo.dart';

part 'single_comment_state.dart';

class SingleCommentCubit extends Cubit<SingleCommentState> {
  SpaceScreenRepo spaceScreenRepo = SpaceScreenRepo();
  SingleCommentCubit() : super(SingleCommentInitial());

  loadComment(int id) async {
    emit(const SingleCommentLoading());
    var response = await spaceScreenRepo.getComment(id);
    if (response.statusCode == 200) {
      emit(SingleCommentLoaded(
          comment: NewPostComment.fromJson(
              jsonDecode(utf8.decode(response.bodyBytes)))));

      // if(response.statusCode == 200){
      //   emit(SingleCommentLoaded(comment: NewPostComment.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      // }else{
      //   emit(SingleCommentError());
      // }
    }
  }
  
}
