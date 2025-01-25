
import 'package:flatemates_ui/controllers/homemates.controller.dart';
import 'package:flatemates_ui/controllers/preference_controller.dart';
import 'package:flatemates_ui/controllers/register.controller.dart';
import 'package:flatemates_ui/firebase_options.dart';
import 'package:flatemates_ui/res/font/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/google_controller.dart';
import 'navigation/app_routes/routes.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeMates App',
      theme: ThemeData(
        fontFamily: AppFonts.familyPoppins,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.routes,
      initialBinding: InitialBindings(), // Add the binding here
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GoogleController()); // Initialize the AuthController
    Get.put(RegisterUserController());
    Get.put(PreferenceController());
   // Get.put(HomemateController());
  }
}


