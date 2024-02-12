import 'package:http/http.dart';

import '../../../../../Core/network/request_helper.dart';

class SpaceScreenRepo {
  Future<Response> getspacePosts(String spaceId, String? filter) async {
    var response = await RequestHelper.get(
        "space/posts/?id=$spaceId&filter=${filter ?? 'recent'}");
    return response;
  }

  Future<Response> getSpacePostComments(String spaceId) async {
    var response = await RequestHelper.get("api/post-comments/?id=$spaceId");
    print(spaceId);
    return response;
  }

  Future<Response> getComment(int commentId) async {
    var response = await RequestHelper.get("api/comment/$commentId");
    return response;
  }
}
