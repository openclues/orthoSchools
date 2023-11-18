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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool? isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Image.asset(
                      'assets/images/Certification.png',
                      fit: BoxFit.contain,
                      width: 250.0,
                      height: 250.0,
                    ),
                  ),
                ),
                Text(
                  "Sign in to recharge direct",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "it you don't have an account you can Register here!",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: const Color.fromARGB(255, 109, 109, 109)),
                ),
                SizedBox(
                  height: 30.0,
                ),
                CustomTextField(
                  labelText: 'Email',
                  borderColor: Color(0XFFF5F6F8),
                  textfiledColor: Color(0XFFF5F6F8),
                  controller: emailController,
                  hintText: "e-mail address",
                  fieldicon:
                      Icon(Icons.lock, color: Color(0XFF939199), size: 15),
                ),
                CustomTextField(
                  labelText: 'Password',
                  borderColor: Color(0XFFF5F6F8),
                  textfiledColor: Color(0XFFF5F6F8),
                  controller: passwordController,
                  hintText: "Password",
                  fieldicon:
                      Icon(Icons.lock, color: Color(0XFF939199), size: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                CheckboxListTile(
                  secondary: InkWell(
                    onTap: () {
                      //go to reser password screen
                    },
                    child: Text('Forgot your password?'),
                  ),
                  contentPadding: EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'Keep me signed in',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = !isChecked!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            CustomButton(
              height: 43,
              buttonText: 'Sign In',
              buttonColor: Color(0XFF3D6CE7),
              onpress: () {
                checkRequiredData(context);
              },
            ),
            SizedBox(
              height: 30,
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
                      text: 'New to OrthoUniversity?  ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF3D6CE7),
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
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
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
            'email': userEmail,
          }));
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
