import 'package:animate_do/animate_do.dart';
import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/interests/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../home_screen/presentation/pages/home_screen.dart';

class ChooseInterestsScreen extends StatefulWidget {
  static const routeName = '/choose-interests';
  const ChooseInterestsScreen({super.key});

  @override
  State<ChooseInterestsScreen> createState() => _ChooseInterestsScreenState();
}

class _ChooseInterestsScreenState extends State<ChooseInterestsScreen> {
  //animate the container

  containerShake() {
    //animate the container
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                height: 50,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      PageAnimationTransition(
                        page: const HomeScreenPage(),
                        pageAnimationType: BottomToTopTransition(),
                      ), (route) {
                    return false;
                  });
                },
                child: const Text('Next', style: TextStyle(fontSize: 20)),
              ),
            ),
            const Text(
              'Skip',
              style: TextStyle(color: primaryColor, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Choose your ',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                    children: [
                      TextSpan(
                        text: 'interests',
                        style: TextStyle(
                            // background: Paint()..color = primaryColor,
                            backgroundColor: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                alignment: WrapAlignment.spaceAround,
                children: interests
                    .map((e) => Bounce(
                          duration:
                              Duration(milliseconds: e.name!.length * 100),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                e.isSelected = !e.isSelected!;
                              });
                              //animate the contrinaer
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: e.isSelected!
                                      ? primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: e.isSelected!
                                          ? primaryColor
                                          : Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.name!,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: e.isSelected!
                                              ? Colors.white
                                              : Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
