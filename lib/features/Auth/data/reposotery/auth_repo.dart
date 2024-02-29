import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart';

class AuthRepo {
  Future<Response> loginUser(String password, String email) async {
    var response = await RequestHelper.post(
      ApiEndpoints.login,
      signup: true,
      {
        'password': password,
        'email': email,
      },
    );
    return response;
  }

  Future<Response> signUpUser(
      String password, String email, String firstName, String lastName) async {
    var response = await RequestHelper.post(
      ApiEndpoints.signUp,
      signup: true,
      {
        'password': password,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
      },
    );
    return response;
  }
}



