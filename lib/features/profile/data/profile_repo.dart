import 'package:http/http.dart';

import '../../../Core/network/request_helper.dart';

class ProfileRepo {
  Future<Response> getProfile(String id) async {
    var response = await RequestHelper.get('visit/profile/$id');
    return response;
  }

  Future<Response> getMyProfile(){
    return RequestHelper.get('myprofile');

  }
}
