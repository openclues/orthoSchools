import 'package:shared_preferences/shared_preferences.dart';

class Common {
  static String MAIN_API_URL = "";
  static String DatabaseNamse = '';

  static Future getMainUrlFormStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mainUrl = prefs.getString("MAIN_API_URL") ?? "main url ";
    String databaseName = prefs.getString("DatabaseName") ?? "name of db";
    MAIN_API_URL = mainUrl;
    DatabaseNamse = databaseName;
    return mainUrl;
  }
}
