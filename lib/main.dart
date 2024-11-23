import 'package:flatemates_ui/res/font/font_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'navigation/app_routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flatemates_ui/ui/screens/list_my_room_screen/list_my_room.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.routes,
      // initialRoute: AppRoutes.bottomNavBar,
      // getPages: AppRoutes.routes,
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }
