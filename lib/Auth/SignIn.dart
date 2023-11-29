import 'dart:convert';

import 'package:azsoon/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/TextField.dart';
import '../widgets/Button.dart';
import '../widgets/Label.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:azsoon/Core/common-methods.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static String? userEmailAddress;

  // @override
  // void initState() {
  //   super.initState();
  //   // Load the user email from shared preferences when the widget is initialized
  //   loadUserEmail();
  // }

  // Future<void> loadUserEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // Retrieve the user email from shared preferences
  //   String? savedEmail = prefs.getString('email');

  //   setState(() {
  //     userEmailAddress = savedEmail; // If null, set an empty string
  //   });
  // }

  bool? isChecked = false;
  bool passwordVisibilty = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: ListView(
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      width: 250.0,
                      height: 100.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Login In",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 50, 50, 50),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Welcone back!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 103, 103, 103)),
                ),
                SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  obscureText: false,
                  labelText: 'Email',
                  borderColor: Color.fromARGB(255, 176, 176, 176),
                  textfiledColor: Colors.white,
                  controller: emailController,
                  hintText: "e-mail address",
                ),
                CustomTextField(
                  obscureText: passwordVisibilty,
                  labelText: 'Password',
                  iconButton: IconButton(
                    padding: EdgeInsetsDirectional.only(end: 12.0),
                    icon: passwordVisibilty
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        passwordVisibilty = !passwordVisibilty;
                      });
                    },
                  ),
                  borderColor: Color.fromARGB(255, 176, 176, 176),
                  textfiledColor: Colors.white,
                  controller: passwordController,
                  hintText: "Password",
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'stay logged in',
                    style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 102, 102, 102)),
                  ),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = !isChecked!;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            CustomButton(
              height: 47,
              buttonText: 'Log in',
              buttonColor: Color(0XFF2F7EDB),
              onpress: () {
                checkRequiredData(context);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Forgot your password?',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0XFF2F7EDB), fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('signUp');
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account?  ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF2F7EDB),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

//checking for empty fileds
  Future<void> checkRequiredData(BuildContext context) async {
    if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'please fill out all fields',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 166, 221, 247),
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }
    completeLogiIn(
        emailController.text.trim(), passwordController.text.trim(), context);
  }

  static Future<void> completeLogiIn(
      String userEmail, userPassword, BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);

    try {
      var response = await http.post(
          Uri.parse('https://orthoschools.com/auth/token/login/'),
          body: ({
            'password': userPassword,
            'email': userEmail, //was userEmail
          }));
      print(userEmailAddress);
      if (response.statusCode == 200) {
        await pr.show();
        final databody = jsonDecode(response.body);
        print("=====================${response.body}");
        print(databody['auth_token']); //the token i need to save

        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('login',
            databody['auth_token']); // i saved the token as string named login
        await pref.setString('email', userEmail);
        await pref.setString('password', userPassword);
        //request the endoint get user data
        await pr.hide();
        //i should navigate to homescreen
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
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
        return;
      } else {
        print(response.statusCode);
        // staus code 403 unauthorized
        //go to login screen
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
