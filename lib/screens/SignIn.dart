import 'package:flutter/material.dart';
import '../widgets/TextField.dart';
import '../widgets/Button.dart';
import '../widgets/Label.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool? isChecked = false;
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
                CustomLabel(
                  labelText: 'Email',
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: "e-mail address",
                  fieldicon:
                      Icon(Icons.lock, color: Color(0XFF939199), size: 15),
                ),
                SizedBox(
                  height: 30.0,
                ),
                CustomLabel(
                  labelText: 'Password',
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
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
              buttonText: 'Sign In',
              buttonColor: Color(0XFF3D6CE7),
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
}
