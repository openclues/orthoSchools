import 'package:azsoon/features/blog/cubit/like_cubit_cubit.dart';
import 'package:http/http.dart';

import '../../../Core/network/request_helper.dart';

class LikeRepo {
  Future<Response> likeOrUnlike(
      String objectId, ObjectTypeContent objectTypeContent) async {
    if (objectTypeContent == ObjectTypeContent.SPACEPOST) {
      return await RequestHelper.get('post/interact/?post_id=$objectId');
    } else if (objectTypeContent == ObjectTypeContent.COMMENT) {
      return await RequestHelper.get('comment/interact/?comment_id=$objectId');
    } else if (objectTypeContent == ObjectTypeContent.ARTICLE) {
      return await RequestHelper.get('article/interact/?article_id=$objectId');
    } else {
      throw Exception("Invalid object type");
    }
  }
}

//    path('post/interact', LikeAndUnlikePost.as_view(), name='like_and_unlike_post'),
  //  path('comment/interact/', LikeAndUnlikeComment.as_view(), name='like_and_unlike_comment'),
//    path('article/interact/', LikeAndUnlikeArticle.as_view(), name='like_and_unlike_post'),
