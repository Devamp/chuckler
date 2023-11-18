import 'package:flutter/material.dart';

class SmoothPageTransition extends PageRouteBuilder {
  final Widget child;

  SmoothPageTransition({required this.child})
      : super(
    pageBuilder: (_, __, ___) => child,
    transitionsBuilder: (_, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation.drive(
          CurveTween(curve: Curves.easeInOutExpo),
        ),
        child: child,
      );
    },
  );
}