import 'package:http/http.dart';

import '../../../../Core/network/request_helper.dart';

class HomeScreenRepo {
  Future<Response> getHomeScreenData() async {
    var response = await RequestHelper.get('homedata/');
    return response;
  }
}
