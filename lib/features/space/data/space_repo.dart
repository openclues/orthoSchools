import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';


class SpaceRepo {
  Future<Response> getSpace(String id) async {
    var response = await RequestHelper.get('space/$id');
    return response;
  }

  Future<Response> getMySpaces({String? userId}) async {
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
  Future<Response> addPost(
    String spaceId,
    String? content,
    List<XFile>? images,
    int? blogpost,
    XFile? video,
  ) async {
    List<MultipartFile> imageFiles = [];
    if (images != null) {
      for (var image in images) {
        imageFiles.add(await MultipartFile.fromPath('post_images', image.path));
      }
    }
    print(video);
    var response = await RequestHelper.post(
        'postcreate/',
        {
          'blogPost': blogpost,
          'space': spaceId,
          'content': content,
          'title': "dspfksdpf",
          "post_files": [],
        }..removeWhere((key, value) => value == null),
        files: images,
        extrafiles: video != null ? [video] : [],
        filesKey: 'post_images',
        extraFilesKey: 'video');
    return response;
  }

  Future<Response> getPost(String postId) async {
    var response = await RequestHelper.get('post/$postId');
    return response;
  }

  Future<Response> getPostComments(String postId) {
    return RequestHelper.get('api/post-comments/?id=$postId');
  }

  Future<Response> getSpacePosts(String spaceId, {String? filter}) {
    filter == "null" ? "recent" : filter;
    return RequestHelper.get('space/posts/?id=$spaceId&filter=$filter');
  }
}
