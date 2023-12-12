import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences getInstance() {
    if (_preferences == null) {
      throw Exception("SharedPreferences have not been initialized yet.");
    }
    return _preferences!;
  }

  static bool? getSkippedPlan() {
    SharedPreferences prefs = LocalStorage.getInstance();
    return prefs.getBool('skipped');
  }

  static Future<void> setSkippedPlan() async {
    SharedPreferences prefs = LocalStorage.getInstance();
    await prefs.setBool('skipped', true);
  }

  static Future<void> removeSkipped() async {
    SharedPreferences prefs = LocalStorage.getInstance();
    await prefs.remove('skipped');
  }

  static Future<void> saveAuthToken(String token) async {
    SharedPreferences prefs = LocalStorage.getInstance();
    await prefs.setString("auth_token", token);
  }

  static Future<void> removeAuthToken() async {
    SharedPreferences prefs = LocalStorage.getInstance();
    await prefs.remove("auth_token");
  }

  static Future<void> removeAll() async {
    SharedPreferences prefs = LocalStorage.getInstance();
  }

  static Future<void> setPreferredLanguage(String languageCode) async {
    SharedPreferences prefs = LocalStorage.getInstance();
    await prefs.setString("preferred_language", languageCode);
  }

  static Future<void> removePreferredLanguage() async {
    SharedPreferences prefs = LocalStorage.getInstance();
    await prefs.remove("preferred_language");
  }

  static String getPreferredLanguage() {
    SharedPreferences prefs = LocalStorage.getInstance();
    return prefs.getString('preferred_language') ?? 'en';
  }

  static getString(String key) {
    SharedPreferences prefs = LocalStorage.getInstance();

    return prefs.getString(key);
  }

  static String? savedLanguage() {
    SharedPreferences prefs = LocalStorage.getInstance();

    return prefs.getString("savedLanguage");
  }

  static removeSavedLnaguage() {
    SharedPreferences prefs = LocalStorage.getInstance();

    return prefs.remove("savedLanguage");
  }

  static saveLanguage(BuildContext context, String language) {
    SharedPreferences prefs = LocalStorage.getInstance();

    prefs.setString('savedLanguage', language);
  }

  static Size getcreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // static launchUrlFunction(String url) async {
  //   try {
  //     await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  //   } catch (e) {}
  // }

//   static launchWhatsAppUri(String phoneNumber, String message) async {
//     final link = WhatsAppUnilink(
//       phoneNumber: phoneNumber,
//       text: message,
//     );
//     // Convert the WhatsAppUnilink instance to a Ur
//     // The "launch" method is part of "url_launcher".
//     await launchUrl(Uri.parse('whatsapp://send?phone=${phoneNumber}'
//         "&text=${Uri.encodeComponent(message)}"));
//   }
// }

// enum DonationStatus { Donator, NonDonator, InactiveDonator }
}
