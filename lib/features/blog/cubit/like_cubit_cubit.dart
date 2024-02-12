import 'dart:convert';

import 'package:azsoon/features/blog/cubit/like_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'like_cubit_state.dart';

enum ObjectTypeContent { SPACEPOST, COMMENT, REPLY, ARTICLE }

class LikeCubitCubit extends Cubit<LikeCubitState> {
  LikeCubitCubit() : super(LikeCubitInitial());

  likeUnlike(int objectId, ObjectTypeContent objectType) async {
    emit(const LikeLoading(true));
    var response =
        await LikeRepo().likeOrUnlike(objectId.toString(), objectType);
    print(response.body);
    emit(LikeLoaded(
        isLiked: jsonDecode(utf8.decode(response.bodyBytes))['isLiked'],
        likesCount: jsonDecode(utf8.decode(response.bodyBytes))['parent_likes_count']));
    // emit(LikeLoading(false));
  }
}
