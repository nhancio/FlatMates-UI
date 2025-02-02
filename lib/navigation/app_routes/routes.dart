// lib/Jay/navigation/app_routes/routes.dart

import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/ui/screens/preference_screen/preference_screen.dart';
import 'package:flatemates_ui/ui/screens/register_yourself_screen/register_yourself.dart';
import 'package:flatemates_ui/ui/screens/verify_otp_screen/verification_otp.dart';
import 'package:flatemates_ui/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui/screens/register_screen/register_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String register = '/register';
  static const String verification = '/verification';
  static const String registerUser = '/registerUser';
  static const String preferences = '/preferences';
  static const String bottomNavBar = '/bottomNavBar';

  static List<GetPage> routes = [
    GetPage(name: welcome, page: () => WelcomeScreen(), customTransition: CustomPageTransition()),
    GetPage(name: register, page: () => RegisterScreen(), customTransition: CustomPageTransition()),
    GetPage(
      name: verification,
      page: () => VerificationScreen(), customTransition: CustomPageTransition()
    ),
    GetPage(name: registerUser, page: () => RegisterUserScreen(), customTransition: CustomPageTransition()),
    GetPage(name: preferences, page: () => PreferenceScreen(), customTransition: CustomPageTransition()),
    GetPage(name: bottomNavBar, page: () => BottomNavBarScreen(), customTransition: CustomPageTransition()),
  ];
}
class CustomPageTransition extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(0.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
