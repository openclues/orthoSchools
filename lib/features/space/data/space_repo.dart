import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SpaceRepo {
  Future<http.Response> getSpace(String id) async {
    var response = await RequestHelper.get('space/$id');
    return response;
  }

  Future<http.Response> getMySpaces({String? userId}) async {
    if (userId != null) {
      var response = await RequestHelper.get('myspaces/?id=$userId');
      print(response.body);

      print("myspaces/?id=$userId");
      return response;
    } else {
      var response = await RequestHelper.get('myspaces/');
      return response;
    }
  }

  //add post
  Future<http.Response> addPost(
    String spaceId,
    String? content,
    List<XFile>? images,
    int? blogpost,
    XFile? video,
  ) async {
    // List<http.MultipartFile> imageFiles = [];
    // if (images != null) {
    //   for (var image in images) {
    //     imageFiles
    //         .add(await http.MultipartFile.fromPath('post_images', image.path));
    //   }
    // }

    var blogpostMap = {
      "blogPost": blogpost?.toString(),
      "space": spaceId.toString(),
      "content": content,
      "title": "dspfksdpf",
    }..removeWhere((key, value) => value == null);
    Map<String, String> blogpostMap2 = blogpostMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    var response = await RequestHelper.postDataWithFiles(
        apiUrl: '${ApiEndpoints.baseUrl}/postcreate/',
        data: blogpostMap2,
        imageFiles: images,
        videoFile: video);
    return response;
  }

  Future<http.Response> getPost(String postId) async {
    var response = await RequestHelper.get('post/$postId');
    return response;
  }

  Future<http.Response> getPostComments(String postId) {
    return RequestHelper.get('api/post-comments/?id=$postId');
  }

  Future<http.Response> getSpacePosts(String spaceId, {String? filter}) {
    filter == "null" ? "recent" : filter;
    return RequestHelper.get('space/posts/?id=$spaceId&filter=$filter');
  }
}
