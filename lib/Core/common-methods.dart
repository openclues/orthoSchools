import 'package:shared_preferences/shared_preferences.dart';

class CommonMethods {
  static Future<void> logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
