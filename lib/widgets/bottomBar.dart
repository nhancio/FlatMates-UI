/*
import 'package:flatmates/controllers/bottom_bar_controller.dart';
import 'package:flatmates/screen/chat_screen/chat.dart';
import 'package:flatmates/screen/chat_screen/home_chat_screen.dart';
import 'package:flatmates/screen/flate_mates.dart';
import 'package:flatmates/screen/home_screen/home_screen.dart';
import 'package:flatmates/screen/profile_screen.dart';
import 'package:flatmates/screen/speech_text_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:flatmates/theme/app_colors.dart';  // Import your AppColors

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
    final BottomNavController controller = Get.put(BottomNavController());


  // final List<Widget> _screens = [
  //   HomeScreen(), // Chat Screen (Placeholder)
  //   SpeechTextScreen(), // Edit Screen (Placeholder)
  //   FlatmateRoomScreen(),
  //  MessagesScreen(),

  //   ProfileScreen(), // Profile Screen
  // ];

   final List<Widget> _screens = [
    HomeScreen(), 
    SpeechTextScreen(), 
    FlatmateRoomScreen(),
    const MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex.value,
        children: _screens,
      )),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightBackground
          : AppColors.darkBackground,
      items: _buildBottomNavBarItems(context),
      currentIndex: controller.selectedIndex.value,
      selectedItemColor: AppColors.primarySwatch,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
      onTap: (index) => controller.changeTabIndex(index),
    ));
  }

  List<BottomNavigationBarItem> _buildBottomNavBarItems(BuildContext context) {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Iconsax.home),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.radio_button_checked),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search_sharp),  
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Iconsax.messages_24),  
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        label: '',
      ),
    ];
  }
}
*/
