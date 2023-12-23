import 'package:flutter/material.dart';

enum SlideDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}

class CustomSlidePageRoute extends PageRouteBuilder {
  final Widget page;
  final SlideDirection slideDirection;
  final Duration duration;

  CustomSlidePageRoute({
    required this.page,
    this.slideDirection = SlideDirection.leftToRight,
    this.duration = const Duration(milliseconds: 500),
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin;
            Offset end;

            switch (slideDirection) {
              case SlideDirection.leftToRight:
                begin = const Offset(-1, 0);
                end = const Offset(0, 0);
                break;
              case SlideDirection.rightToLeft:
                begin = const Offset(1, 0);
                end = const Offset(0, 0);
                break;
              case SlideDirection.topToBottom:
                begin = const Offset(0, -1);
                end = const Offset(0, 0);
                break;
              case SlideDirection.bottomToTop:
                begin = const Offset(0, 1);
                end = const Offset(0, 0);
                break;
            }

            var tween = Tween(begin: begin, end: end);
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: duration,
        );
}
