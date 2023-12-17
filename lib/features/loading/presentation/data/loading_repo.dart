import 'package:http/http.dart';

import '../../../../Core/network/request_helper.dart';

class LoadingRepo {
    Future<Response> getMyProfile(){
    return RequestHelper.get('myprofile');

  }

}