import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/profile/data/my_profile_model.dart';

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
    await prefs.setString("authToken", token);
  }

  static Future<void> removeAuthToken() async {
    SharedPreferences prefs = LocalStorage.getInstance();
    await prefs.remove("authToken");
  }

  static Future<void> removeAll() async {
    SharedPreferences prefs = LocalStorage.getInstance();
    await prefs.remove("authToken");
    RequestHelper.removeAuthToken();
    await prefs.clear();
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
  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) return "${(diff.inDays / 365).floor()} years ago";
    if (diff.inDays > 30) return "${(diff.inDays / 30).floor()} months ago";
    if (diff.inDays > 7) return "${(diff.inDays / 7).floor()} weeks ago";
    if (diff.inDays > 0) return "${diff.inDays} days ago";
    if (diff.inHours > 0) return "${diff.inHours} hours ago";
    if (diff.inMinutes > 0) return "${diff.inMinutes} mins ago";
    return "just now";
  }

  static Profile? currentUser(BuildContext context) {
    ProfileState state = context.read<ProfileBloc>().state;
    if (state is ProfileLoaded) {
      return state.profileModel;
    }
    return null;
  }

  static extractCountryCode(String phoneNumber) {
    // Map of country codes and their corresponding prefixes
    Map<String, String> countryCodes = {
      'AD': '+376',
      'AE': '+971',
      'AF': '+93',
      'AG': '+1-268',
      'AI': '+1-264',
      'AL': '+355',
      'AM': '+374',
      'AO': '+244',
      'AQ': '+672',
      'AR': '+54',
      'AS': '+1-684',
      'AT': '+43',
      'AU': '+61',
      'AW': '+297',
      'AX': '+358-18',
      'AZ': '+994',
      'BA': '+387',
      'BB': '+1-246',
      'BD': '+880',
      'BE': '+32',
      'BF': '+226',
      'BG': '+359',
      'BH': '+973',
      'BI': '+257',
      'BJ': '+229',
      'BL': '+590',
      'BM': '+1-441',
      'BN': '+673',
      'BO': '+591',
      'BQ': '+599',
      'BR': '+55',
      'BS': '+1-242',
      'BT': '+975',
      // 'BV': '',
      'BW': '+267',
      'BY': '+375',
      'BZ': '+501',
      'CA': '+1',
      'CC': '+61',
      'CD': '+243',
      'CF': '+236',
      'CG': '+242',
      'CH': '+41',
      'CI': '+225',
      'CK': '+682',
      'CL': '+56',
      'CM': '+237',
      'CN': '+86',
      'CO': '+57',
      'CR': '+506',
      'CU': '+53',
      'CV': '+238',
      'CW': '+599',
      'CX': '+61',
      'CY': '+357',
      'CZ': '+420',
      'DE': '+49',
      'DJ': '+253',
      'DK': '+45',
      'DM': '+1-767',
      'DO': '+1-809',
      'DZ': '+213',
      'EC': '+593',
      'EE': '+372',
      'EG': '+20',
      'EH': '+212',
      'ER': '+291',
      'ES': '+34',
      'ET': '+251',
      'FI': '+358',
      'FJ': '+679',
      'FK': '+500',
      'FM': '+691',
      'FO': '+298',
      'FR': '+33',
      'GA': '+241',
      'GB': '+44',
      'GD': '+1-473',
      'GE': '+995',
      'GF': '+594',
      'GG': '+44-1481',
      'GH': '+233',
      'GI': '+350',
      'GL': '+299',
      'GM': '+220',
      'GN': '+224',
      'GP': '+590',
      'GQ': '+240',
      'GR': '+30',
      'GS': '+500',
      'GT': '+502',
      'GU': '+1-671',
      'GW': '+245',
      'GY': '+592',
      'HK': '+852',
      'HM': '+672',
      'HN': '+504',
      'HR': '+385',
      'HT': '+509',
      'HU': '+36',
      'ID': '+62',
      'IE': '+353',
      'IL': '+972',
      'IM': '+44-1624',
      'IN': '+91',
      'IO': '+246',
      'IQ': '+964',
      'IR': '+98',
      'IS': '+354',
      'IT': '+39',
      'JE': '+44-1534',
      'JM': '+1-876',
      'JO': '+962',
      'JP': '+81',
      'KE': '+254',
      'KG': '+996',
      'KH': '+855',
      'KI': '+686',
      'KM': '+269',
      'KN': '+1-869',
      'KP': '+850',
      'KR': '+82',
      'KW': '+965',
      'KY': '+1-345',
      'KZ': '+7',
      'LA': '+856',
      'LB': '+961',
      'LC': '+1-758',
      'LI': '+423',
      'LK': '+94',
      'LR': '+231',
      'LS': '+266',
      'LT': '+370',
      'LU': '+352',
      'LV': '+371',
      'LY': '+218',
      'MA': '+212',
      'MC': '+377',
      'MD': '+373',
      'ME': '+382',
      'MF': '+590',
      'MG': '+261',
      'MH': '+692',
      'MK': '+389',
      'ML': '+223',
      'MM': '+95',
      'MN': '+976',
      'MO': '+853',
      'MP': '+1-670',
      'MQ': '+596',
      'MR': '+222',
      'MS': '+1-664',
      'MT': '+356',
      'MU': '+230',
      'MV': '+960',
      'MW': '+265',
      'MX': '+52',
      'MY': '+60',
      'MZ': '+258',
      'NA': '+264',
      'NC': '+687',
      'NE': '+227',
      'NF': '+672',
      'NG': '+234',
      'NI': '+505',
      'NL': '+31',
      'NO': '+47',
      'NP': '+977',
      'NR': '+674',
      'NU': '+683',
      'NZ': '+64',
      'OM': '+968',
      'PA': '+507',
      'PE': '+51',
      'PF': '+689',
      'PG': '+675',
      'PH': '+63',
      'PK': '+92',
      'PL': '+48',
      'PM': '+508',
      'PN': '+64',
      'PR': '+1-787',
      'PS': '+970',
      'PT': '+351',
      'PW': '+680',
      'PY': '+595',
      'QA': '+974',
      'RE': '+262',
      'RO': '+40',
      'RS': '+381',
      'RU': '+7',
      'RW': '+250',
      'SA': '+966',
      'SB': '+677',
      'SC': '+248',
      'SD': '+249',
      'SE': '+46',
      'SG': '+65',
      'SH': '+290',
      'SI': '+386',
      'SJ': '+47',
      'SK': '+421',
      'SL': '+232',
      'SM': '+378',
      'SN': '+221',
      'SO': '+252',
      'SR': '+597',
      'SS': '+211',
      'ST': '+239',
      'SV': '+503',
      'SX': '+599',
      'SY': '+963',
      'SZ': '+268',
      'TC': '+1-649',
      'TD': '+235',
      // 'TF': '',
      'TG': '+228',
      'TH': '+66',
      'TJ': '+992',
      'TK': '+690',
      'TL': '+670',
      'TM': '+993',
      'TN': '+216',
      'TO': '+676',
      'TR': '+90',
      'TT': '+1-868',
      'TV': '+688',
      'TW': '+886',
      'TZ': '+255',
      'UA': '+380',
      'UG': '+256',
      'UM': '+1',
      'US': '+1',
      'UY': '+598',
      'UZ': '+998',
      'VA': '+379',
      'VC': '+1-784',
      'VE': '+58',
      'VG': '+1-284',
      'VI': '+1-340',
      'VN': '+84',
      'VU': '+678',
      'WF': '+681',
      'WS': '+685',
      'YE': '+967',
      'YT': '+262',
      'ZA': '+27',
      'ZM': '+260',
      'ZW': '+263',
    };

    Map<String, String> phone = countryCodes.map((key, value) {
      if (phoneNumber.startsWith(value)) {
        return MapEntry(key, value);
      }
      return const MapEntry("", "");
    });

    print(phone..removeWhere((key, value) => key.isEmpty));
    return phone..removeWhere((key, value) => key.isEmpty);
    // return phone.removeWhere((key, value) => key.isEmpty);
    // Iterate over the country codes
    // for (var entry in countryCodes.entries) {
    //   // If the phone number starts with the country code
    //   print(entry.key.);
    //   // if (phoneNumber
    //   //     .replaceAll("+", "")
    //   //     .startsWith(entry.value.toLowerCase().replaceAll("+", ""))) {
    //   //   // Return the country code
    //   //   print(entry.key);
    //   // }
    // }
  }

  static detectLanguage(String litter) {
    RegExp exp = RegExp(r'[a-zA-Z]');
    if (litter.isEmpty) return 'en';
    if (exp.hasMatch(litter)) {
      return 'en';
    } else {
      return 'ar';
    }
  }
}
