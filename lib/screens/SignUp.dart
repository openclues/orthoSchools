import 'package:flutter/material.dart';
import '../widgets/TextField.dart';
import '../widgets/Button.dart';
import '../widgets/Label.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;
  TextEditingController fullNameController = TextEditingController();
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
                CustomLabel(
                  labelText: 'Full Name',
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: fullNameController,
                  hintText: "Full Name",
                  fieldicon:
                      Icon(Icons.person, color: Color(0XFF939199), size: 17),
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
                  controller: emailController,
                  hintText: "e-email address",
                  fieldicon:
                      Icon(Icons.email, color: Color(0XFF939199), size: 15),
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
                  controller: passwordController,
                  hintText: "Password",
                  fieldicon:
                      Icon(Icons.lock, color: Color(0XFF939199), size: 15),
                ),
                SizedBox(
                  height: 30.0,
                ),
                CustomLabel(
                  labelText: 'Re-Password',
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
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
              buttonText: 'Sign Up',
              buttonColor: Color(0XFF3D6CE7),
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
}
