import 'package:http/http.dart';

import '../../../Core/network/request_helper.dart';

class ArticlesRepo {
  Future<Response> getRecommendedBlogs() async {
    var response = await RequestHelper.get('api/recommended-blogs/');
    return response;
  }

  Future<Response> getArticles({String? category, bool? following}) async {
    var response = await RequestHelper.get(
        "article/?${category != null ? 'search=$category' : ""}${following == true ? '&following=$following' : ''}");
    return response;
  }

  Future<Response> getArticleComments(String id) async {
    var responses = await RequestHelper.get('article/comments/?post_id=$id');
    return responses;
  }

  likeAndUnlikeArticle(String id) async {
    var response = await RequestHelper.get('article/interact/?article_id=$id');
    return response;
  }
}
