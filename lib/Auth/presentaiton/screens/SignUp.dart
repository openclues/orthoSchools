import 'dart:convert';
import 'package:azsoon/Auth/presentaiton/screens/SignIn.dart';
import 'package:azsoon/screens/CreateProfile.dart';
import 'package:azsoon/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/TextField.dart';
import '../../../widgets/Button.dart';
// import '../../../widgets/Label.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../bussiness_logi/cubit/auth_cubit_cubit.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signUp';

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
    return BlocConsumer<AuthCubitCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is AuthSignedUp) {
          //create the AuthSignedUp
          Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return buildSignUpForm(context);
      },
    );
  }

  Widget buildSignUpForm(BuildContext context) {
    return BlocBuilder<AuthCubitCubit, AuthCubitState>(
      builder: (context, state) {
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
                      'Create an Account',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
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
                    state is! AuthLoading
                        ? Text('welcome!')
                        : CircularProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            obscureText: false,
                            labelText: 'First Name',
                            borderColor: Color.fromARGB(255, 176, 176, 176),
                            textfiledColor: Colors.white,
                            controller: firstNameController,
                            hintText: "First Name",
                          ),
                        ),
                        SizedBox(
                            width: 16), // Adjust the spacing between fields
                        Expanded(
                          child: CustomTextField(
                            obscureText: false,
                            labelText: 'Last Name',
                            borderColor: Color.fromARGB(255, 176, 176, 176),
                            textfiledColor: Colors.white,
                            controller: lastNameController,
                            hintText: "Last Name",
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      obscureText: false,
                      labelText: 'Email',
                      borderColor: Color.fromARGB(255, 176, 176, 176),
                      textfiledColor: Colors.white,
                      controller: emailController,
                      hintText: "e-email address",
                    ),
                    CustomTextField(
                      obscureText: false,
                      labelText: 'Password',
                      borderColor: Color.fromARGB(255, 176, 176, 176),
                      textfiledColor: Colors.white,
                      controller: passwordController,
                      hintText: "Password",
                    ),
                    CustomTextField(
                      obscureText: false,
                      labelText: 'Re-Passowrd',
                      borderColor: Color.fromARGB(255, 176, 176, 176),
                      textfiledColor: Colors.white,
                      controller: rePassowrdController,
                      hintText: "Re-Password",
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
                    SizedBox(
                      height: 3.0,
                    ),
                  ],
                ),
                CustomButton(
                  height: 47,
                  buttonText: 'Sign up',
                  buttonColor: Color(0XFF2F7EDB),
                  onpress: () {
                    checkRequiredDataThenSignUp(context);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signIn');
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'have an account?  ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Sign In',
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
      },
    );
  }

//checking for empty fileds and signup
  Future<void> checkRequiredDataThenSignUp(BuildContext context) async {
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
      //add it to constants
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

    print('=============================');
    context.read<AuthCubitCubit>().signUp(
        passwordController.text.trim(),
        emailController.text.trim(),
        firstNameController.text.trim(),
        lastNameController.text.trim());
  }
}
