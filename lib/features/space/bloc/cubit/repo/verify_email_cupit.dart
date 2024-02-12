import 'package:http/http.dart';

import '../../../../../Core/network/request_helper.dart';

class VerifyEmailRepo {
  //send code to email
  Future<Response> verifyEmail(String code) async {
    var response = await RequestHelper.post('verify/email/', {
      'code': code,
    });
    return response;
  }

  //verify email

  Future<Response> sendCodeToEmail() async {
    var response = await RequestHelper.get('sendemailcode/');
    return response;
  }
}
