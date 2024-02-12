import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../Core/colors.dart';

class NavigationIndicatorWidget extends StatelessWidget {
  const NavigationIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: -50,
        right: 0,
        left: 0,
        child: BounceInUp(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: Container(
            height: 80,
            width: 100,
            decoration: const BoxDecoration(
                color: primaryColor, shape: BoxShape.circle),
          ),
        ));
  }
}


