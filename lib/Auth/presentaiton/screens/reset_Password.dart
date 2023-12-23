import 'package:azsoon/widgets/Button.dart';
import 'package:azsoon/widgets/TextField.dart';
import 'package:flutter/material.dart';

import '../../../Core/colors.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = '/resetPassword';
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.help_outline))],
      ),
      body: firstStep(),
    );
  }
}

class firstStep extends StatefulWidget {
  const firstStep({
    super.key,
  });

  @override
  State<firstStep> createState() => _firstStepState();
}

class _firstStepState extends State<firstStep> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Reset password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Enter the email associated with your account and we\'ll send and email with instructions to reset your password.',
                style: TextStyle(color: Colors.grey, fontSize: 19),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                obscureText: false,
                labelText: 'Email address',
                borderColor: const Color.fromARGB(255, 176, 176, 176),
                textfiledColor: Colors.white,
                controller: emailController,
                hintText: "example@example.com",
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                buttonText: 'Next',
                buttonColor: primaryColor,
                borderColor: primaryColor,
                textColor: white,
                onpress: () {
                  Navigator.of(context).pushNamed('/secondStepReset');
                },
                height: 47,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SecondStep extends StatelessWidget {
  static const String routeName = '/secondStepReset';
  const SecondStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.help_outline))],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: ListView(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/Mail sent-rafiki.png',
                  width: 300,
                ),
                Text(
                  'Check your mail',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'We have sent a password recover instructions to your email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 19),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  child: CustomButton(
                    buttonText: 'Open email app',
                    buttonColor: primaryColor,
                    borderColor: primaryColor,
                    textColor: white,
                    onpress: () {
                      Navigator.of(context).pushNamed('/thirdStep');
                    },
                    height: 47,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdStep extends StatefulWidget {
  static const String routeName = '/thirdStep';
  const ThirdStep({
    super.key,
  });

  @override
  State<ThirdStep> createState() => _ThirdStepState();
}

class _ThirdStepState extends State<ThirdStep> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassowrdController = TextEditingController();
  bool passwordVisibilty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.help_outline))],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Create new password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Your new password must be different from previous used passwords.',
                  style: TextStyle(color: Colors.grey, fontSize: 19),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
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
                  hintText: "password must be at least 8 characters.",
                ),
                CustomTextField(
                  obscureText: passwordVisibilty,
                  labelText: 'Confirm Password',
                  borderColor: Color.fromARGB(255, 176, 176, 176),
                  textfiledColor: Colors.white,
                  controller: confirmPassowrdController,
                  hintText: "both passwords must match",
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  buttonText: 'Reset Passowrd',
                  buttonColor: primaryColor,
                  borderColor: primaryColor,
                  textColor: white,
                  onpress: () {
                    Navigator.of(context).pushNamed('/secondStepReset');
                  },
                  height: 47,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}