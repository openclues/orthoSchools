import 'dart:convert';
import 'package:azsoon/screens/CreateProfile.dart';
import 'package:flutter/material.dart';
import '../widgets/TextField.dart';
import '../widgets/Button.dart';
import '../widgets/Label.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePassowrdController = TextEditingController();

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
                  'Create an Account',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "I'm a subhead that goes with a story.",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: const Color.fromARGB(255, 109, 109, 109)),
                ),
                SizedBox(
                  height: 30.0,
                ),
                CustomTextField(
                  labelText: 'First Name',
                  borderColor: Color(0XFFF5F6F8),
                  textfiledColor: Color(0XFFF5F6F8),
                  controller: firstNameController,
                  hintText: "First Name",
                  fieldicon:
                      Icon(Icons.person, color: Color(0XFF939199), size: 17),
                ),
                CustomTextField(
                  labelText: 'Last Name',
                  borderColor: Color(0XFFF5F6F8),
                  textfiledColor: Color(0XFFF5F6F8),
                  controller: lastNameController,
                  hintText: "last Name",
                  fieldicon:
                      Icon(Icons.person, color: Color(0XFF939199), size: 17),
                ),
                CustomTextField(
                  labelText: 'Email',
                  borderColor: Color(0XFFF5F6F8),
                  textfiledColor: Color(0XFFF5F6F8),
                  controller: emailController,
                  hintText: "e-email address",
                  fieldicon:
                      Icon(Icons.email, color: Color(0XFF939199), size: 15),
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
                CustomTextField(
                  labelText: 'Re-Passowrd',
                  borderColor: Color(0XFFF5F6F8),
                  textfiledColor: Color(0XFFF5F6F8),
                  controller: rePassowrdController,
                  hintText: "Re-Password",
                  fieldicon:
                      Icon(Icons.lock, color: Color(0XFF939199), size: 15),
                ),
                SizedBox(
                  height: 20.0,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'i agree to the ',
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: 'Terms & Conditions',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = !isChecked!;
                    });
                  },
                ),
              ],
            ),
            CustomButton(
              height: 43,
              buttonText: 'Sign Up',
              buttonColor: Color(0XFF3D6CE7),
              onpress: () {
                registerUser(context);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('signIn');
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already in eduker ?  ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: 'Sign In',
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

  Future<void> registerUser(BuildContext context) async {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        rePassowrdController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'please fill out all fields',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 166, 221, 247),
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (passwordController.text.length < 8) {
      Fluttertoast.showToast(
          msg: 'password must be 8 char or more',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 166, 221, 247),
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (passwordController.text != rePassowrdController.text) {
      Fluttertoast.showToast(
          msg: 'passwords fields not match',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 166, 221, 247),
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }

    //no prpblem with the entered data
    Map<String, dynamic> data = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      'first_name': firstNameController.text.trim(),
      'last_name': lastNameController.text.trim(),
    };
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);

    try {
      pr.show();
      var response = await http.post(
        Uri.parse('https://orthoschools.com/register/'),
        body: data,
      );
      print("=============================${response.body}");
      //could be : ============================={"email":["user with this email already exists."]}
      pr.hide();

      if (response.statusCode == 201) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('token')) {
          print(responseData.containsKey('token'));
          Fluttertoast.showToast(
            msg: 'Registration successful!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
          //go to create profiel page and in this page if he presses skip go to home and if he  presses save that mena he uploaded data and typed text in his profiel so use provider to get this data in his profile page
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CreateProfileScreen()),
              (route) => false);
        } else {
          Fluttertoast.showToast(
            msg: 'registration faild',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'request faild',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } catch (e) {
      pr.hide();
      print(e.toString());
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
