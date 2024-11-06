import 'package:flatemates_ui/Jay/navigation/app_routes/routes.dart';
import 'package:flatemates_ui/Jay/res/font/font_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() async {

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
    );
  }
}
