import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../Core/colors.dart';

class BackButtonWhiteBackground extends StatelessWidget {
  const BackButtonWhiteBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        //animate the notification icon
      },
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 2),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            // ignore: prefer_const_constructors
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: const Icon(
                IconlyBroken.arrow_left_2,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
