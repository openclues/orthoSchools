import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CommonMethods {
  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('login');
  }

  static Future<String?> getUserEmailAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<void> logOut() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('login');
    //log out normal
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
/////////////////////////log out endpoint
    // final urlLogout = Uri.parse('https://orthoschools.com/auth/token/logout/');
    // String? authToken = await CommonMethods.getAuthToken();

    // try {
    //   final response = await http.post(
    //     urlLogout,
    //     headers: {"Authorization": "Token $authToken"},
    //   );
    //   print(response.body);
    //   print(authToken);

    //   if (response.statusCode == 200) {
    //     // Successful logout
    //     print('Logout successful');
    //   } else {
    //     // Handle other status codes if needed
    //     print('Logout failed with status code: ${response.statusCode}');
    //   }
    // } catch (error) {
    //   // Handle errors such as network issues
    //   print('Error during logout: $error');
    // }
  }

  // static Future<void> signIn() {}

  // static Future<void> signUp(String userEmail, userPassword) {}

  // static Future<void> createProfile(String userEmail, ) {}
}
