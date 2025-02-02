import 'package:flutter/material.dart';

class CustomWidgetTransition extends PageRouteBuilder {
  final Widget page;

  CustomWidgetTransition({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(
          begin: const Offset(0.0, 0.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.ease));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
