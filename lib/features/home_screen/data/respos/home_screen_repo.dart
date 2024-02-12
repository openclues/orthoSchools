import 'package:azsoon/Core/network/endpoints.dart';
import 'package:http/http.dart';

import '../../../../Core/network/request_helper.dart';

class HomeScreenRepo {
  Future<Response> getHomeScreenData() async {
    var response = await RequestHelper.get('api/recommended-spaces/');
    return response;
  }

  Future<Response> getHomeScreenPosts({String? next}) async {
    Response response;
    if (next == null) {
      response = await RequestHelper.get('api/home-posts/');
    } else {
      response =
          await RequestHelper.get(next.replaceAll(ApiEndpoints.baseUrl, ''));
    }
    return response;
  }

  Future<Response> getMorePosts(String next) async {
    var response =
        await RequestHelper.get(next.replaceAll(ApiEndpoints.baseUrl, ''));
    return response;
  }
}


// class  ApiService 