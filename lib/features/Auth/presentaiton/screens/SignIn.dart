import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/images_path.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/features/loading/presentation/data/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import '../../../../common_widgets/TextField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bussiness_logi/cubit/auth_cubit_cubit.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signIn';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static String? userEmailAddress;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool? isChecked = false;
  bool passwordVisibilty = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(context.read<AuthCubitCubit>().state);
    return BlocConsumer<AuthCubitCubit, AuthCubitState>(
        listener: (context, state) {
      if (state is AuthLoggedIn) {
        Navigator.of(context).pushReplacementNamed(LoadingScreen.routeName);
      } else if (state is AuthError) {
        // SnackBarWidget.buildSnacBarFail(state.errorMessage, context);
      }
    }, builder: (context, state) {
      return buildSignInForm(context);
    });
  }

  Widget buildSignInForm(BuildContext context) {
    return BlocBuilder<AuthCubitCubit, AuthCubitState>(
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: Colors.,

          body: Container(
            decoration: BoxDecoration(gradient: mainGradient),
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: ListView(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height:
                              LocalStorage.getcreenSize(context).height * 0.4,
                          child: Image.asset(
                            ImagePath.dentistImage,
                            fit: BoxFit.contain,
                            // width: 250.0,
                            // height: 100.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        validator: (b) {
                          if (b!.isEmpty) {
                            return 'please enter your email';
                          }
                          return null;
                        },
                        obscureText: false,
                        labelText: 'Email',
                        borderColor: const Color.fromARGB(255, 176, 176, 176),
                        textfiledColor: Colors.white,
                        controller: emailController,
                        hintText: "Email Address",
                      ),
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'please enter your password';
                          }
                          return null;
                        },
                        obscureText: passwordVisibilty,
                        labelText: 'Password',
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
                        borderColor: const Color.fromARGB(255, 176, 176, 176),
                        textfiledColor: Colors.white,
                        controller: passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 15,
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
                    if (formKey.currentState!.validate()) {
                      checkRequiredData(context);
                    }
                  },
                  child: state is! AuthLoading
                      ? const Text(
                          "Login",
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
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/resetPassword');
                  },
                  child: const Text(
                    'Forgot your password?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 81, 81, 81), fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signUp');
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account?  ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 131, 131, 131)),
                        ),
                        TextSpan(
                          text: 'Sign Up',
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

//checking for empty fileds
  Future<void> checkRequiredData(BuildContext context) async {
    context
        .read<AuthCubitCubit>()
        .login(passwordController.text.trim(), emailController.text.trim());

    // completeLogiIn(
    //     emailController.text.trim(), passwordController.text.trim(), context);
  }

  // static Future<void> completeLogiIn(
  //     String userEmail, userPassword, BuildContext context) async {
  //   ProgressDialog pr = new ProgressDialog(context,
  //       type: ProgressDialogType.normal, isDismissible: false, showLogs: true);

  //   try {
  //     var response = await http.post(
  //         Uri.parse('https://orthoschools.com/auth/token/login/'),
  //         body: ({
  //           'password': userPassword,
  //           'email': userEmail, //was userEmail
  //         }));
  //     print(userEmailAddress);
  //     if (response.statusCode == 200) {
  //       await pr.show();
  //       final databody = jsonDecode(utf8.decode(response.bodyBytes));
  //       print("=====================${response.body}");
  //       print(databody['auth_token']); //the token i need to save

  //       SharedPreferences pref = await SharedPreferences.getInstance();
  //       await pref.setString('login',
  //           databody['auth_token']); // i saved the token as string named login
  //       await pref.setString('email', userEmail);
  //       await pref.setString('password', userPassword);
  //       //request the endoint get user data
  //       await pr.hide();
  //       //i should navigate to homescreen
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => const HomeScreen()),
  //           (route) => false);
  //     } else if (response.statusCode == 400) {
  //       print(response.statusCode);
  //       Fluttertoast.showToast(
  //           msg: 'passwords or emai address is not correct',
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: const Color.fromARGB(255, 166, 221, 247),
  //           textColor: Colors.black,
  //           fontSize: 16.0);
  //       return;
  //     } else {
  //       print(response.statusCode);
  //       // staus code 403 unauthorized
  //       //go to login screen
  //       SharedPreferences pref = await SharedPreferences.getInstance();
  //       await pref.clear();
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => const SignInScreen()),
  //           (route) => false);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }
}
