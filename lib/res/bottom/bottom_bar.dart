/*
import 'package:flatmates/Jay/res/assets/icons/icons.dart';
import 'package:flatmates/Jay/ui/screens/ai_screen/ai_screen.dart';
import 'package:flatmates/Jay/ui/screens/chat_screen/chat_screen.dart';
import 'package:flatmates/Jay/ui/screens/home_screen/home_screen.dart';
import 'package:flatmates/Jay/ui/screens/profile_screen/profile_screen.dart';
import 'package:flatmates/Jay/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
  HomePage(),
    ChatListScreen(),

    HomemateRoomScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home_outlined, 'Home', 0),
              _buildBottomNavItem(Icons.wechat_sharp, 'Chat', 1),
              SizedBox(width: 48), // Space for the FAB
              _buildBottomNavItem(Icons.book_outlined, 'Booking', 2),
              _buildBottomNavItem(Icons.person_outline, 'Profile', 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=> VoiceInputScreen()));
        },
        child:Image.asset(AppIcons.ai,height: 20,width: 20,),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flatemates_ui/controllers/bottomnav.controller.dart';
import 'package:flatemates_ui/res/assets/icons/icons.dart';
import 'package:flatemates_ui/ui/screens/ai_screen/ai_screen.dart';
import 'package:flatemates_ui/ui/screens/chat_screen/chat_screen.dart';
import 'package:flatemates_ui/ui/screens/home_screen/home_screen.dart';
import 'package:flatemates_ui/ui/screens/profile_screen/profile_screen.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BottomNavBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX
    final BottomNavController _bottomNavController =
        Get.put(BottomNavController());

    // Define the pages to be displayed in the body
    final List<Widget> _pages = [
      HomePage(),
      ChatListScreen(),
      HomemateRoomScreen(),
      ProfileScreen(),
      VoiceInputScreen(),
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
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                  Icons.home_outlined, 'Home', 0, _bottomNavController),
              _buildBottomNavItem(
                  Icons.wechat_sharp, 'Chat', 1, _bottomNavController),
              const SizedBox(width: 48), // Space for the FAB
              _buildBottomNavItem(
                  Icons.book_outlined, 'Saved', 2, _bottomNavController),
              _buildBottomNavItem(
                  Icons.person_outline, 'Profile', 3, _bottomNavController),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Update index to navigate to VoiceInputScreen
          _bottomNavController.setIndex(4); // Index for VoiceInputScreen
        },
        child: Image.asset(AppIcons.ai, height: 20, width: 20),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavItem(
      IconData icon, String label, int index, BottomNavController controller) {
    return GestureDetector(
      onTap: () {
        controller.setIndex(index); // Update the current index
      },
      child: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: controller.currentIndex.value == index
                  ? Colors.blueAccent
                  : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                color: controller.currentIndex.value == index
                    ? Colors.blueAccent
                    : Colors.grey,
              ),
            ),
          ],
        );
      }),
    );
  }
}
