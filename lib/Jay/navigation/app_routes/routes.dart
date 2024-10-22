// lib/Jay/navigation/app_routes/routes.dart

import 'package:flatmates/Jay/res/bottom/bottom_bar.dart';
import 'package:flatmates/Jay/ui/screens/preference_screen/preference_screen.dart';
import 'package:flatmates/Jay/ui/screens/register_yourself_screen/register_yourself.dart';
import 'package:flatmates/Jay/ui/screens/verify_otp_screen/verification_otp.dart';
import 'package:get/get.dart';
import 'package:flatmates/Jay/ui/screens/register_screen/register_screen.dart';
import 'package:flatmates/Jay/ui/screens/welcome_screen/welcome_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String register = '/register';
  static const String verification = '/verification';
  static const String registerUser = '/registerUser';
  static const String preferences = '/preferences';
  static const String bottomNavBar = '/bottomNavBar';

  static List<GetPage> routes = [
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: verification, page: () => VerificationScreen()),
    GetPage(name: registerUser, page: () => RegisterUserScreen()),
    GetPage(name: preferences, page: () => PreferenceScreen()),
    GetPage(name: bottomNavBar, page: () => BottomNavBarScreen()),
  ];
}
