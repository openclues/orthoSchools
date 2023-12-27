import 'dart:convert';
import 'dart:io';

import 'package:azsoon/Auth/data/reposotery/auth_repo.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Core/network/request_helper.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  final AuthRepo authRepo = AuthRepo();

  AuthCubitCubit() : super(AuthCubitInitial());

  void login(String password, String email) async {
    emit(AuthLoading());

    try {
      var response = await authRepo
          .loginUser(password, email)
          .timeout(Duration(seconds: 10));
      print(response.body);
      if (response.statusCode == 200) {
        final databody = jsonDecode(response.body);
        String token = databody['auth_token'] as String;

        LocalStorage.saveAuthToken(token);

        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

        String deviceId = '';

        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceId = androidInfo.id;
        } else if (Platform.isIOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceId = iosInfo.identifierForVendor!;
        }
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        String? fcmToken = await messaging.getToken();

        var responses = await RequestHelper.post(
            'register-device/', {"device_id": deviceId, "fcm_token": fcmToken});

        print(
            "+++++++++++++++++++++++++++++++ REGISTER DONE ${responses.body}");
        emit(AuthLoggedIn(token));
      } else if (response.statusCode == 400) {
        print(response.statusCode);
        Fluttertoast.showToast(
            msg: 'passwords or emai address is not correct',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 166, 221, 247),
            textColor: Colors.black,
            fontSize: 16.0);
        emit(AuthError('Invalid credentials'));
      } else {
        emit(AuthError('Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError('An error occurred: $e'));
    }
  }

  void signUp(
      String password, String email, String firstName, String lastName) async {
    try {
      emit(AuthLoading());
      print(password);
      print(email);
      print(firstName);
      print(lastName);

      var response = await authRepo
          .signUpUser(password, email, firstName, lastName)
          .timeout(Duration(seconds: 30));
      print(response.body);

      if (response.statusCode == 201) {
        print("=====================${response.body}");
        final databody = jsonDecode(response.body);
        // String token = databody['auth_token'] as String;
        // LocalStorage.saveAuthToken(token);
        // Save token to shared preferences

        emit(AuthSignedUp());
      } else if (response.statusCode == 400) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('email')) {
          Fluttertoast.showToast(
              msg: 'user with this email already exists',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 166, 221, 247),
              textColor: Colors.black,
              fontSize: 16.0);
          emit(AuthError('user with this email already exists'));
        } else if (responseData.containsKey('password')) {
          Fluttertoast.showToast(
              msg: 'password is too similar to the email',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 166, 221, 247),
              textColor: Colors.black,
              fontSize: 16.0);
          emit(AuthError('password is too similar to the email'));
        }
      } else {
        emit(AuthError('Invalid credentials'));
      }
    } catch (e) {
      print(e.toString());
      emit(AuthError('An error occurred: $e'));
    }
  }

// Map<String, dynamic> data = {
//       'email': emailController.text.trim(),
//       'password': passwordController.text.trim(),
//       'first_name': firstNameController.text.trim(),
//       'last_name': lastNameController.text.trim(),
//     };
//     ProgressDialog pr = new ProgressDialog(context,
//         type: ProgressDialogType.normal, isDismissible: false, showLogs: true);

//     try {
//       pr.show();
//       var response = await http.post(
//         Uri.parse('https://orthoschools.com/register/'),
//         body: data,
//       );
//       print("=============================${response.body}");

//       pr.hide();

//       if (response.statusCode == 201) {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => SignInScreen()),
//             (route) => false);
//       } else if (response.statusCode == 400) {
//         Map<String, dynamic> responseData = json.decode(response.body);

//         if (responseData.containsKey('email')) {
//           Fluttertoast.showToast(
//               msg: 'user with this email already exists',
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               timeInSecForIosWeb: 1,
//               backgroundColor: const Color.fromARGB(255, 166, 221, 247),
//               textColor: Colors.black,
//               fontSize: 16.0);
//           return;
//         } else if (responseData.containsKey('password')) {
//           Fluttertoast.showToast(
//               msg: 'password is too similar to the email',
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               timeInSecForIosWeb: 1,
//               backgroundColor: const Color.fromARGB(255, 166, 221, 247),
//               textColor: Colors.black,
//               fontSize: 16.0);
//           return;
//         }
//       }
//     } catch (e) {
//       pr.hide();
//       print(e.toString());
//       Fluttertoast.showToast(
//         msg: 'An error occurred. Please try again.',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//       );
//     }
}




  // void logout() {}
  ///auth/token/logout/
  // sign-up, logout, etc.

