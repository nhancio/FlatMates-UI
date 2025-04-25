import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/bottomnav.controller.dart';
import 'package:flatemates_ui/navigation/app_routes/routes.dart';
import 'package:flatemates_ui/ui/screens/home_screen/home_screen.dart';
import 'package:flatemates_ui/ui/screens/profile_screen/profile_screen.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/savedItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomNavController _bottomNavController = Get.put(BottomNavController());
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    // Define pages with guest mode handling
    final List<Widget> _pages = [
      HomePage(userId: userId),
      SavedTabBarScreen(userId: FirebaseAuth.instance.currentUser?.uid),
      userId.isEmpty ? Container() : ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Obx(() {
          if (_bottomNavController.currentIndex.value == 2 && userId.isEmpty) {
            // Redirect to welcome screen if trying to access profile while not logged in
            Get.toNamed(AppRoutes.welcome);
            _bottomNavController.setIndex(0);
            return HomePage(userId: userId);
          }
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
                  "assets/amenities/home.png",
                  'Home',
                  0,
                  _bottomNavController,
                  userId,
                ),
                _buildBottomNavItem(
                  "assets/amenities/diskette.png",
                  'Saved',
                  1,
                  _bottomNavController,
                  userId,
                ),
                _buildBottomNavItem(
                  "assets/amenities/user.png",
                  'Profile',
                  2,
                  _bottomNavController,
                  userId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    String image,
    String label,
    int index,
    BottomNavController controller,
    String userId,
  ) {
    return GestureDetector(
      onTap: () {
        if ((index == 1 || index == 2) && userId.isEmpty) {
          // Redirect to welcome screen for saved and profile when not logged in
          Get.toNamed(AppRoutes.welcome);
        } else {
          controller.setIndex(index);
        }
      },
      child: Obx(() {
        bool isSelected = controller.currentIndex.value == index;
        bool isHovered = controller.hoverIndex.value == index;

        return MouseRegion(
          onEnter: (_) => controller.setHoverIndex(index),
          onExit: (_) => controller.setHoverIndex(null),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blueAccent
                  : (isHovered ? Colors.blueGrey[100] : Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AnimatedScale(
                    duration: Duration(milliseconds: 150),
                    scale: isSelected ? 1.4 : 1.1,
                    child: Image.asset(
                      image,
                      color: isSelected
                          ? Colors.white
                          : (isHovered ? Colors.blueGrey : Colors.grey),
                      height: 22,
                      width: 22,
                    ),
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
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