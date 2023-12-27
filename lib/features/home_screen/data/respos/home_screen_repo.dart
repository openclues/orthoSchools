import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/endpoints.dart';
import 'package:http/http.dart';

import '../../../../Core/network/request_helper.dart';

class HomeScreenRepo {
  Future<Response> getHomeScreenData() async {
    var response = await RequestHelper.get('api/recommended-spaces/');
    return response;
  }

  Future<Response> getHomeScreenPosts() async {
    var response = await RequestHelper.get('api/home-posts/');
    print(await RequestHelper.getAuthToken());
    print("++++++++++++++++++++++++++++++++++");
    print(response.body);
    return response;
  }

  Future<Response> getMorePosts(String next) async {
    print(
        "+++++++++++++++++++++++++++++++ ${next.replaceAll(ApiEndpoints.baseUrl, '')}");
    var response =
        await RequestHelper.get(next.replaceAll(ApiEndpoints.baseUrl, ''));
    return response;
  }
}


// class  ApiService 