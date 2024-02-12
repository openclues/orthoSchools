import 'dart:convert';
import 'package:azsoon/model/user-info.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CommonMethods {
  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('login');
  }

  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      // Use the intl package for more human-readable dates
      final formatter = DateFormat.yMMMd();
      return formatter.format(dateTime);
    }
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

  // static Future<Map<String, dynamic>> getUserInfo(String authToken) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://orthoschools.com/user/info'),
  //       headers: {
  //         'Authorization': 'Token $authToken',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // If the server returns a 200 OK response, parse the JSON
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       print(data);
  //       return data;
  //     } else {
  //       // If the server did not return a 200 OK response, throw an exception.
  //       throw Exception('Failed to load user info');
  //     }
  //   } catch (e) {
  //     // Handle potential exceptions, such as network errors.
  //     print('Error: $e');
  //     rethrow;
  //   }
  // }

//   static Future<User> getUserInfo(String authToken) async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://orthoschools.com/user/info'),
//         headers: {
//           'Authorization': 'Token $authToken',
//         },
//       );

//       if (response.statusCode == 200) {
//         // If the server returns a 200 OK response, parse the JSON
//         final Map<String, dynamic> userData = json.decode(response.body);
//         print(userData);

//         // Create a User object from the parsed data
//         User user = User.fromJson(userData['user']);
//         return user;
//       } else {
//         // If the server did not return a 200 OK response, throw an exception.
//         throw Exception('Failed to load user info');
//       }
//     } catch (e) {
//       // Handle potential exceptions, such as network errors.
//       print('Error: $e');
//       rethrow;
//     }
//   }

//   static Future<MoreInfo> getMoreInfo(String authToken) async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://orthoschools.com/user/info'),
//         headers: {
//           'Authorization': 'Token $authToken',
//         },
//       );
//       print("${response.body}dsflsdofpjsdf");
//       if (response.statusCode == 200) {
//         // If the server returns a 200 OK response, parse the JSON
//         final Map<String, dynamic> data = json.decode(response.body);
//         print(data);

//         // Create a MoreInfo object from the parsed data
//         MoreInfo moreInfo = MoreInfo.fromJson(data);
//         return moreInfo;
//       } else {
//         // If the server did not return a 200 OK response, throw an exception.
//         throw Exception('Failed to load user info');
//       }
//     } catch (e) {
//       // Handle potential exceptions, such as network errors.
//       print('Error: $e');
//       rethrow;
//     }
//   }
// }
}
