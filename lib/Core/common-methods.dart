import 'package:shared_preferences/shared_preferences.dart';

class CommonMethods {
  static Future<void> logOut() async {
    //https://orthoschools.com/auth/token/login/
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('login');
  }

  // static Future<void> signIn() {}

  // static Future<void> signUp(String userEmail, userPassword) {}

  // static Future<void> createProfile(String userEmail, ) {}
}
