
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/bottomnav.controller.dart';
import 'package:flatemates_ui/res/assets/icons/icons.dart';
import 'package:flatemates_ui/ui/screens/ai_screen/ai_screen.dart';
import 'package:flatemates_ui/ui/screens/chat_screen/chat_screen.dart';
import 'package:flatemates_ui/ui/screens/home_screen/home_screen.dart';
import 'package:flatemates_ui/ui/screens/profile_screen/profile_screen.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/savedItemScreen.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../ui/image/b.dart';
final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

class BottomNavBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX
    final BottomNavController _bottomNavController =
        Get.put(BottomNavController());

    // Define the pages to be displayed in the body
    final List<Widget> _pages = [
      HomePage(userId: '',),
     // ChatListScreen(),
    //  SavedHomematesScreen(userId: userId,),
      SavedTabBarScreen(),
      ProfileScreen(),
     // VoiceInputScreen(),
    ];

    return Scaffold(

      body: Obx(() {
        // Use Obx to update the body based on the current index from the controller
        return _pages[_bottomNavController.currentIndex.value];
      }),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                  Icons.home, 'Home', 0, _bottomNavController),
             /* _buildBottomNavItem(
                  Icons.wechat_sharp, 'Chat', 1, _bottomNavController),
              const SizedBox(width: 48), // Space for the FAB*/
              _buildBottomNavItem(
                  Icons.save, 'Saved', 1, _bottomNavController),
              _buildBottomNavItem(
                  Icons.supervised_user_circle_sharp, 'Profile', 2, _bottomNavController),
            ],
          ),
        ),
      ),
    /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Update index to navigate to VoiceInputScreen
          _bottomNavController.setIndex(4); // Index for VoiceInputScreen
        },
        child: Image.asset(AppIcons.ai, height: 20, width: 20),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
    );
  }

  Widget _buildBottomNavItem(
      IconData icon, String label, int index, BottomNavController controller) {
    return GestureDetector(
      onTap: () {
        controller.setIndex(index); // Update the current index
      },
      child: Obx(() {
        bool isSelected = controller.currentIndex.value == index;
        bool isHovered = controller.hoverIndex.value == index;

        return MouseRegion(
          onEnter: (_) {
            controller.setHoverIndex(index); // Set hover index
          },
          onExit: (_) {
            controller.setHoverIndex(null); // Reset hover index
          },
          child: AnimatedContainer(

            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blueAccent
                  : (isHovered ? Colors.blueGrey[100] : Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjusted padding

            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AnimatedScale(
                    duration: Duration(milliseconds: 150),
                    scale: isSelected ? 1.4 : 1.1, // Slightly increased scaling effect
                    child: Icon(
                      icon,
                      size: 22, // Set a fixed size for the icon
                      color: isSelected
                          ? Colors.white
                          : (isHovered ? Colors.blueGrey : Colors.grey),
                    ),
                  ),
                ),
             //   SizedBox(height: 4), // Add spacing between icon and text
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12, // Reduced font size
                    color: isSelected
                        ? Colors.white
                        : (isHovered ? Colors.blueGrey : Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

}