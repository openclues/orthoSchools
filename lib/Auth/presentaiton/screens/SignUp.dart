import 'dart:convert';
import 'package:azsoon/Auth/presentaiton/screens/SignIn.dart';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/images_path.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/screens/CreateProfile.dart';
import 'package:azsoon/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/snacbars/success_snacbar.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? isChecked = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePassowrdController = TextEditingController();
  bool passwordVisibilty = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubitCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is AuthSignedUp) {
          //create the AuthSignedUp
          Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
        } else if (state is AuthError) {
          SnackBarWidget.buildSnacBarFail(state.errorMessage, context);
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
          backgroundColor: Colors.white,
          body: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height:
                              LocalStorage.getcreenSize(context).height * 0.3,
                          child: Image.asset(
                            ImagePath.doctorsImage,
                            fit: BoxFit.contain,
                            // width: 250.0,
                            // height: 100.0,
                          ),
                        ),
                      ),
                      const Text(
                        'Create an Account',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "I'm a subhead that goes with a story.",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 109, 109, 109)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'first name is required';
                                }
                              },
                              obscureText: false,
                              labelText: 'First Name',
                              borderColor:
                                  const Color.fromARGB(255, 176, 176, 176),
                              textfiledColor: Colors.white,
                              controller: firstNameController,
                              hintText: "First Name",
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Adjust the spacing between fields
                          Expanded(
                            child: CustomTextField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'last name is required';
                                }
                              },
                              obscureText: false,
                              labelText: 'Last Name',
                              borderColor:
                                  const Color.fromARGB(255, 176, 176, 176),
                              textfiledColor: Colors.white,
                              controller: lastNameController,
                              hintText: "Last Name",
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'email is required';
                          }
                        },
                        obscureText: false,
                        labelText: 'Email',
                        borderColor: const Color.fromARGB(255, 176, 176, 176),
                        textfiledColor: Colors.white,
                        controller: emailController,
                        hintText: "Email address",
                      ),
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'password is required';
                          }
                          if (v.length < 8) {
                            return 'password must be at least 8 characters.';
                          }
                        },
                        obscureText: passwordVisibilty,
                        labelText: 'Password',
                        borderColor: const Color.fromARGB(255, 176, 176, 176),
                        textfiledColor: Colors.white,
                        controller: passwordController,
                        hintText: "Password",
                        iconButton: IconButton(
                          padding: const EdgeInsetsDirectional.only(end: 12.0),
                          icon: passwordVisibilty
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passwordVisibilty = !passwordVisibilty;
                            });
                          },
                        ),
                      ),
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'password is required';
                          }

                          if (v != passwordController.text) {
                            return 'passwords fields not match';
                          }
                        },
                        obscureText: passwordVisibilty,
                        labelText: 'Confirm Passowrd',
                        borderColor: const Color.fromARGB(255, 176, 176, 176),
                        textfiledColor: Colors.white,
                        controller: rePassowrdController,
                        hintText: "Confirm Passowrd",
                      ),
                      // CheckboxListTile(
                      //   contentPadding: EdgeInsets.all(0),
                      //   controlAffinity: ListTileControlAffinity.leading,
                      //   title: RichText(
                      //     text: TextSpan(
                      //       children: <TextSpan>[
                      //         TextSpan(
                      //             text: 'i agree to the ',
                      //             style: TextStyle(color: Colors.grey)),
                      //         TextSpan(
                      //             text: 'Terms & Conditions',
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black)),
                      //       ],
                      //     ),
                      //   ),
                      //   value: isChecked,
                      //   onChanged: (bool? value) {
                      //     setState(() {
                      //       isChecked = !isChecked!;
                      //     });
                      //   },
                      // ),
                      const SizedBox(
                        height: 3.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  elevation: 0,
                  height: 47,
                  color: primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Color(0XFF8174CC), // Use default if not provided
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      checkRequiredDataThenSignUp(context);
                    }
                  },
                  child: state is! AuthLoading
                      ? const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signIn');
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'have an account?  ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(
                  height: 15,
                ),
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
      SnackBarWidget.buildSnacBarFail("Please fill out all fields", context);
      // Fluttertoast.showToast(
      //     msg: 'please fill out all fields',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: const Color.fromARGB(255, 166, 221, 247),
      //     textColor: Colors.black,
      //     fontSize: 16.0);
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
