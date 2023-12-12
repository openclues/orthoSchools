import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'space_model.dart';

class SpaceRepo {
  Future<Response> getSpace(String id) async {
    var response = await RequestHelper.get('space/${id}');
    return response;
  }

  Future<Response> getMySpaces() async {
    var response = await RequestHelper.get('myspaces/');
    return response;
  }

  //add post
  Future<Response> addPost(
      String spaceId, String? content, List<XFile>? images) async {
    List<MultipartFile> imageFiles = [];
    if (images != null) {
      for (var image in images) {
        imageFiles.add(await MultipartFile.fromPath('post_images', image.path));
      }
    }

    var response = await RequestHelper.post(
        'postcreate/',
        {
          'space': spaceId,
          'content': content,
          'title': "dspfksdpf",
          "post_files": [],
        },
        files: images,
        filesKey: 'post_images');
    return response;
  }

  Future<Response> getPost(String postId) async {
    var response = await RequestHelper.get('post/$postId');
    return response;
  }
}
