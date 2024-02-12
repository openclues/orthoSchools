import 'package:azsoon/Core/network/endpoints.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:http/http.dart';

class AuthRepo {
  Future<Response> loginUser(String password, String email) async {
    print('====================================');
    print(password);
    print(email);
    print('====================================');
    var response = await RequestHelper.post(
      ApiEndpoints.login,
      signup: true,
      {
        'password': password,
        'email': email,
      },
    );
    print(response);
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



