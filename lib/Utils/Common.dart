import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common {
  static String MAIN_API_URL = "";
  static String DatabaseNamse = '';

  static Future getMainUrlFormStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String MAIN_URL = prefs.getString("MAIN_API_URL") ?? "main url ";
    String Database_NAME = prefs.getString("DatabaseName") ?? "name of db";
    MAIN_API_URL = MAIN_URL;
    DatabaseNamse = Database_NAME;
    return MAIN_URL;
  }
}
